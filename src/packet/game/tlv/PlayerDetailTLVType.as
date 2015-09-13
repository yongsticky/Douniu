package packet.game.tlv
{
	import packet.game.tlv.value.T3DMJPlayInfo;
	import packet.game.tlv.value.TDNPlayInfo;

	public class PlayerDetailTLVType
	{
		public static const EN_PLAYERDETAIL_TLV_3DMJ:int = 1;
		public static const EN_PLAYERDETAIL_TLV_DN:int = 2;
		
		public function PlayerDetailTLVType()
		{
			throw new Error("Abstract class, you must extend it.");
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
					throw new Error("tlvType [" + tlvType + "] NOT Match any TLVValue.");
			}
		}
	}
}