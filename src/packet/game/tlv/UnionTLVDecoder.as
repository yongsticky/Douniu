package packet.game.tlv
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.Logger;
	import camu.logger.LEVEL;	
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
			var typeTLV:int = peekTLVType(bytes);
						
			var uTLV:UnionTLV = NiuObjectFactory.instance().createUnionTLVInstance(typeTLV);
			if (uTLV)
			{
				if (!uTLV.unpack(bytes))
				{					
					NiuObjectFactory.instance().destroyInstance(uTLV);
					uTLV = null;
				}
			}
			else
			{
				throw new Error("Not UnionTLV Class.");
			}
			
			return uTLV;
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