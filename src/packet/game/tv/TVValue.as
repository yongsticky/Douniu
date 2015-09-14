package packet.game.tv
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVDecoder;

	public class TVValue
	{
		public var tlv_num:int;					// short(2)		
		public var tlv_vec:Vector.<UnionTLV>;		// ?
		
		public function TVValue()
		{
			tlv_vec = new Vector.<UnionTLV>();
		}
		
		public function getTLVValue(tlvType:int) : *
		{
			for (var i:int = 0; i < tlv_num; ++i)
			{
				var uTLV:UnionTLV = tlv_vec[i];
				if (uTLV && uTLV.valueType == tlvType)
				{
					return uTLV.value;
				}
			}
			
			return null;
		}
		
		public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(tlv_num);
			if (tlv_num > 0)
			{
				for (var i:int = 0; i < tlv_num; i++)
				{
					tlv_vec[i].pack(bytes);
				}
			}
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			tlv_num = bytes.readShort();
			
			if (tlv_num > 0)
			{				
				var _uTLVDecoder:UnionTLVDecoder = UnionTLVDecoder.instance();		
				for (var i:int = 0; i < tlv_num; i++)
				{
					var uTLV:UnionTLV = _uTLVDecoder.decode(bytes);
					tlv_vec.push(uTLV);
				}
			}
		}
		
		public function dispose() : void
		{
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:UnionTLV in tlv_vec)
			{				
				_factory.destroyInstance(item);
			}
			
			tlv_vec.length = 0;
			tlv_num = 0;
		}
		
		public function printValue(logger:ILogger) : void
		{			
			logger.log(this, "tlv_num:", tlv_num, LEVEL.INFO);
			for each(var tlv:UnionTLV in tlv_vec)
			{
				logger.log(this, "tlv.valueType", tlv.valueType, LEVEL.INFO);
				tlv.value.printValue(logger);
			}
		}
		
	}	
	
}