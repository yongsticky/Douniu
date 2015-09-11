package controller
{
	public class NiuHandlerConstant
	{
		public static const ENTER_HALL:String = "enter_hall";
		public static const ENTER_ROOM:String = "click_room";
		
		public static const PLAYER_ENTER:String = "player_enter";
		public static const PLAYER_LEAVE:String = "player_leave";
		
		public static const OTHERPLAYER_ENTER:String = "otherplayer_enter";
		public static const OTHERPLAYER_LEAVE:String = "otherplayer_leave";		
		public static const OTHERPLAYER_READY:String = "otherplayer_ready";
		
		public static const READY_TIMER:String = "ready_timer";
		
		
		public function NiuHandlerConstant()
		{
			throw new Error("static abstract class, do not create instance.");
		}
	}
}