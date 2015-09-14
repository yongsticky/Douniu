package packet.game.tlv
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import factory.NiuObjectFactory;


	public final class UnionTLVDecoder
	{
		protected var _logger:ILogger;
		
		public function UnionTLVDecoder(inner:PrivateInner)
		{
			_logger = Logger.createLogger(UnionTLVDecoder, LEVEL.INFO);
		}
		
		private static var _instance:UnionTLVDecoder = null;
		public static function instance() : UnionTLVDecoder
		{
			if (!_instance)
			{
				_instance = new UnionTLVDecoder(new PrivateInner());
			}
			
			return _instance;
		}

		public function decode(bytes:ByteArray) : UnionTLV
		{
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();			
			
			var tlvType:int = peekTLVType(bytes);
			var tlvValue:TLVValue = _factory.createInstance(TLVType.TLVTypeToClass(tlvType));
			if (tlvValue)
			{
				var uTLV:UnionTLV = _factory.createInstance(UnionTLV) as UnionTLV;
				if (uTLV)
				{
					uTLV.value = tlvValue;
					
					uTLV.unpack(bytes);	
					
					_logger.log(this, "decode tlv, type:[",tlvType,"]", LEVEL.INFO);
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
			
			_logger.log(this, "peekTLVType, TLV Type = ", tlvType, LEVEL.INFO);

			return tlvType;
		}
	}
}

class PrivateInner
{
	
}