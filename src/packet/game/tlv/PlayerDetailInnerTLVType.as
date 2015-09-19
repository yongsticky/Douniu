package packet.game.tlv
{
	import camu.errors.AbstractClassError;
	import camu.errors.UnhandledBranchError;
	
	import packet.game.tlv.value.T3DMJPlayInfo;
	import packet.game.tlv.value.TDNPlayInfo;

	public class PlayerDetailInnerTLVType
	{
		public static const EN_PLAYERDETAIL_TLV_3DMJ:int = 1;
		public static const EN_PLAYERDETAIL_TLV_DN:int = 2;
		
		public function PlayerDetailInnerTLVType()
		{
			throw new AbstractClassError();			
		}
		
		public static function TLVTypeToClass(tlvType:int) : Class
		{
			switch(tlvType)
			{
				case EN_PLAYERDETAIL_TLV_3DMJ:
					return T3DMJPlayInfo;
				case EN_PLAYERDETAIL_TLV_DN:
					return TDNPlayInfo;
				default:
					throw new UnhandledBranchError("tlvType [" + tlvType + "] NOT Match any TLVValue.");					
			}
		}
	}
}