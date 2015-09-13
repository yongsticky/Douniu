package controller
{
	public class NiuNotificationHandlerConstant
	{
		public static const STARTUP:String = "startup";		
		public static const SERVER_CONNECTED:String = "server_connected";
		public static const SELECT_USER:String = "select_user";		
		public static const LOGIN_SUCCESS:String = "login_success";
		public static const SELECT_ROOM:String = "select_room";
		
		public static const PLAYER_ENTER:String = "player_enter";		
		public static const OTHERPLAYER_ENTER:String = "otherplayer_enter";
		
				
		public function NiuNotificationHandlerConstant()
		{
			throw new Error("static abstract class, do not create instance.");
		}
	}
}