package packet.game.tlv
{
	import flash.utils.ByteArray;
		
	import camu.errors.NullObjectError;
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import factory.NiuObjectFactory;

	public class PlayerDetailInnerUnionTLVDecoder
	{
		protected var _logger:ILogger;
		
		public function PlayerDetailInnerUnionTLVDecoder(inner:PrivateInner)
		{
			_logger = Logger.createLogger(PlayerDetailInnerUnionTLVDecoder, LEVEL.INFO);
		}
		
		private static var _instance:PlayerDetailInnerUnionTLVDecoder = null;
		public static function instance() : PlayerDetailInnerUnionTLVDecoder
		{
			if (!_instance)
			{
				_instance = new PlayerDetailInnerUnionTLVDecoder(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function decode(bytes:ByteArray) : UnionTLV
		{
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();			
			
			var tlvType:int = peekTLVType(bytes);
			var tlvValue:TLVValue = _factory.createInstance(PlayerDetailInnerTLVType.TLVTypeToClass(tlvType));
			if (tlvValue)
			{
				var uTLV:UnionTLV = _factory.createInstance(UnionTLV) as UnionTLV;
				if (uTLV)
				{
					uTLV.value = tlvValue;
					
					uTLV.unpack(bytes);	
					
					_logger.log(this, "decode playerdetail tlv, type:[",tlvType,"]", LEVEL.INFO);
					
					return uTLV;
				}			
				
			}			
			
			throw new NullObjectError();			
		}
		
		public function peekTLVType(bytes:ByteArray) : int
		{
			var tlvType:int = bytes.readShort();
			bytes.position -= 2;
			
			_logger.log(this, "peekTLVType, TLV Type = ", tlvType, LEVEL.INFO);
			
			return tlvType;
		}
	}
}

class PrivateInner
{
	
}