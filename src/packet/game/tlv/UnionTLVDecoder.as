package packet.game.tlv
{
	import flash.utils.ByteArray;
	
	import camu.design_pattern.Singleton;
	
	import factory.NiuObjectFactory;


	public final class UnionTLVDecoder
	{
		public function UnionTLVDecoder()
		{
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
			
			return uTLV;
		}

		public function peekTLVType(bytes:ByteArray) : int
		{
			var typeTLV:int = bytes.readShort();
			bytes.position -= 2;

			return typeTLV;
		}
	}
}