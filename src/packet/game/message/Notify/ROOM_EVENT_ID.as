package packet.game.message.Notify
{
	import camu.errors.AbstractClassError;

	public class ROOM_EVENT_ID
	{
		public static const LOGIN:int = 1;
		public static const LOGOUT:int = 2;
		public static const SITDOWN:int = 3;
		public static const STANDUP:int = 4;
		public static const GAME_START:int = 5;
		public static const GAME_END:int = 6;
		public static const READY:int = 7;
		public static const VIEW_SEAT:int = 8;
		public static const RELOGIN:int = 9;
		public static const OFFLINE:int = 10;
		public static const MONEY_CHANGE:int = 11;
		public static const KICKED:int = 12;
		public static const SCORE_CHANGE:int = 13;
		public static const ENTER_ROOM_UI_INIT_OK:int = 14;
		public static const COUNT_NORMAL_ITEM_CHANGE:int = 15;
		public static const PRESENT_BEAN_FAILED:int = 16;
		public static const CANCEL_VIEW_SEAT:int = 17;
		
		public function ROOM_EVENT_ID()
		{
			throw new AbstractClassError();		
		}
	}
}