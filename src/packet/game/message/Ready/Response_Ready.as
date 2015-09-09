package packet.game.message.Ready
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.ResponseResult;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVDecoder;
	import packet.protocol.NiuResponsePacket;
	
	public class Response_Ready extends NiuResponsePacket
	{
		public var rresult:ResponseResult;		// ?
		public var tlv_num:int;					// short(2)
		public var tlv_vec:Vector.<UnionTLV>;	// ?

		public function Response_Ready()
		{
			super();
			
			rresult = new ResponseResult();
			tlv_vec = new Vector.<UnionTLV>();
		}


		override public function unpackMsgParam(bytes:ByteArray) : void
		{			
			rresult.unpack(bytes);
			tlv_num = bytes.readShort();
			if (tlv_num > 0)
			{
				var _uTLVDecoder:UnionTLVDecoder = UnionTLVDecoder.instance();
				for (var i:int = 0; i < tlv_num; i++)
				{
					var utlv:UnionTLV = _uTLVDecoder.decode(bytes);
					tlv_vec.push(utlv);						
				}
			}
		}
		
		override public function onObjectRecycled() : void
		{
			super.onObjectRecycled();
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:UnionTLV in tlv_vec)
			{				
				_factory.destroyInstance(item);
			}
			
			tlv_num = 0;
			tlv_vec.length = 0;
		}

	}
}