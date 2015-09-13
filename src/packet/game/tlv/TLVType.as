package packet.game.tlv
{
	import packet.game.tlv.value.BaseGameCfgData;
	import packet.game.tlv.value.ExitPlayerInfo;
	import packet.game.tlv.value.GameMsgInfo;
	import packet.game.tlv.value.GameScoreValue;
	import packet.game.tlv.value.LockInfo;
	import packet.game.tlv.value.PlayerCapability;
	import packet.game.tlv.value.PlayerDetailInfo;
	import packet.game.tlv.value.PlayerMoneyChangeInfo;
	import packet.game.tlv.value.PlayerViewSeatInfo;
	import packet.game.tlv.value.TAppointmentKey;
	import packet.game.tlv.value.TClientInfo;
	import packet.game.tlv.value.TCometeBuffer;
	import packet.game.tlv.value.TDealerInfo;
	import packet.game.tlv.value.TMatchTickKey;
	import packet.game.tlv.value.TMultipleInfo;
	import packet.game.tlv.value.TPlayerAvatarChangeInfo;
	import packet.game.tlv.value.TPlayerCountNormalItemChangeInfo;
	import packet.game.tlv.value.TPlayerKickOutInfo;
	import packet.game.tlv.value.TTilesInfo;
	import packet.game.tlv.value.TTimerInfo;
	import packet.game.tlv.value.TableSimpleInfo;

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
		
		public static const SO_UP_TLV_TILES_KEY:int = 20001;
		public static const SO_UP_TLV_TIMER_KEY:int = 20002;
		public static const SO_UP_TLV_DEALER_KEY:int = 20003;
		public static const SO_UP_TLV_MULTIPLE_KEY:int = 20004;
		
		public function TLVType()
		{
			throw new Error("Abstract class, you must extend it.");
		}
		
		public static function TLVTypeToClass(tlvType:int) : Class
		{
			switch(tlvType)
			{
				case UP_TLV_APPOINTMENT_KEY:			// 1
					return TAppointmentKey;
				case UP_TLV_TGA_COMETE_BUFFER:			// 2
					return TCometeBuffer;				
				case UP_TLV_CLIENT_INFO:				// 3
					return TClientInfo;
				case UP_TLV_MATCH_TICK_KEY:				// 4
					return TMatchTickKey;
					//case TLVType.DN_TLV_SVRINFO:					// 10000
					//	return null;
				case DN_TLV_PLAYERDETAIL:				// 10001
					return PlayerDetailInfo;
					//case TLVType.DN_TLV_ITEMINFO:					// 10002
					//	return null;
				case DN_TLV_VIEW_SEAT_INFO:				// 10003
					return PlayerViewSeatInfo;
				case DN_TLV_KICKOUT_INFO:				// 10004
					return TPlayerKickOutInfo;
				case DN_TLV_TABLE_SIMPLE_INFO:			// 10005
					return TableSimpleInfo;
				case DN_TLV_MONEY_CHANGE_INFO:			// 10006
					return PlayerMoneyChangeInfo;
				case DN_TLV_COUNT_NORMAL_ITEM_CHANGE_INFO:	// 10007
					return TPlayerCountNormalItemChangeInfo;
				case DN_TLV_GAME_MSG_INFO:				// 10008
					return GameMsgInfo;
				case DN_TLV_LOCK_INFO:					// 10009
					return LockInfo;
				case DN_TLV_BASE_GAME_CFG:				// 10010
					return BaseGameCfgData;
				case DN_TLV_AVATAR_CHANGE_INFO:			// 10011
					return TPlayerAvatarChangeInfo;
				case DN_TLV_PLAYER_CAPABILITY:			// 10012
					return PlayerCapability;
				case DN_TLV_EXIT_PLAYER_INFO:			// 10013
					return ExitPlayerInfo;
				case DN_TLV_GAME_LOGIC_MSG:				// 10014
					return null;
				case DN_TLV_GAME_SCORE_MSG:				// 10015
					return GameScoreValue;
				case SO_UP_TLV_TILES_KEY:
					return TTilesInfo;
				case SO_UP_TLV_TIMER_KEY:
					return TTimerInfo;
				case SO_UP_TLV_DEALER_KEY:
					return TDealerInfo;
				case SO_UP_TLV_MULTIPLE_KEY:
					return TMultipleInfo;					
				default:
					throw new Error("tlvType [" + tlvType + "] NOT Match any TLVValue.");
			}
		}
	}
}