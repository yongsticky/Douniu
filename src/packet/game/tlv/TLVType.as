package packet.game.tlv
{
	public final class TLVType
	{
		public static const UP_TLV_APPOINTMENT_KEY:int =1;
		public static const UP_TLV_TGA_COMETE_BUFFER:int = 2;
		public static const UP_TLV_CLIENT_INFO:int = 3;
		public static const UP_TLV_MATCH_TICK_KEY:int = 4;
		public static const DN_TLV_SVRINFO:int = 1000;
		public static const DN_TLV_PLAYERDETAIL:int = 10001;
		public static const DN_TLV_ITEMINFO:int = 10002;
		public static const DN_TLV_VIEW_SEAT_INFO:int = 10003;
		public static const DN_TLV_KICKOUT_INFO:int = 10004;
		public static const DN_TLV_TABLE_SIMPLE_INFO:int = 10005;
		public static const DN_TLV_MONEY_CHANGE_INFO:int = 10006;
		public static const DN_TLV_COUNT_NORMAL_ITEM_CHANGE_INFO:int = 10007;
		public static const DN_TLV_GAME_MSG_INFO:int = 10008;
		public static const DN_TLV_LOCK_INFO:int = 10009;
		public static const DN_TLV_BASE_GAME_CFG:int = 10010;
		public static const DN_TLV_AVATAR_CHANGE_INFO:int = 10011;
		public static const DN_TLV_PLAYER_CAPABILITY:int = 10012;
		public static const DN_TLV_EXIT_PLAYER_INFO:int = 10013;
		public static const DN_TLV_GAME_LOGIC_MSG:int = 10014;
		public static const DN_TLV_GAME_SCORE_MSG:int = 10015;
		
		public function TLVType()
		{
			throw new Error("Abstract class.");
		}
	}
}