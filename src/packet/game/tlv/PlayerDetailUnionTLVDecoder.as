package packet.game.tlv
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import factory.NiuObjectFactory;

	public class PlayerDetailUnionTLVDecoder
	{
		private var _logger:ILogger;
		
		public function PlayerDetailUnionTLVDecoder(inner:PrivateInner)
		{
			_logger = Logger.createLogger(PlayerDetailUnionTLVDecoder, LEVEL.INFO);
		}
		
		private static var _instance:PlayerDetailUnionTLVDecoder = null;
		public static function instance() : PlayerDetailUnionTLVDecoder
		{
			if (!_instance)
			{
				_instance = new PlayerDetailUnionTLVDecoder(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function decode(bytes:ByteArray) : UnionTLV
		{
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();			
			
			var tlvType:int = peekTLVType(bytes);
			var tlvValue:TLVValue = _factory.createInstance(PlayerDetailTLVType.TLVTypeToClass(tlvType));
			if (tlvValue)
			{
				var uTLV:UnionTLV = _factory.createInstance(UnionTLV) as UnionTLV;
				if (uTLV)
				{
					uTLV.value = tlvValue;
					
					uTLV.unpack(bytes);	
					
					_logger.log("decode playerdetail tlv, type:[",tlvType,"]", LEVEL.INFO);
				}
				else
				{
					throw new Error("Not UnionTLV Class.");	
				}
				
				return uTLV;
			}					
			
			throw new Error("TLV [type=" + tlvType + "] NOT EXIST!");
		}
		
		public function peekTLVType(bytes:ByteArray) : int
		{
			var tlvType:int = bytes.readShort();
			bytes.position -= 2;
			
			_logger.log("peekTLVType, TLV Type = ", tlvType, LEVEL.INFO);
			
			return tlvType;
		}
	}
}

class PrivateInner
{
	
}