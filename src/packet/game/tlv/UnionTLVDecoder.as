package packet.game.tlv
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.singleton.Singleton;
	
	import factory.NiuObjectFactory;


	public final class UnionTLVDecoder
	{
		private var _logger:ILogger;
		
		public function UnionTLVDecoder()
		{
			_logger = Logger.createLogger(UnionTLVDecoder, LEVEL.INFO);
		}
		
		public static function instance() : UnionTLVDecoder
		{
			return Singleton.instanceOf(UnionTLVDecoder);
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