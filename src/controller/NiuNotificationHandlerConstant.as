package controller
{
	public class NiuNotificationHandlerConstant
	{
		public static const STARTUP:String = "startup";		
		public static const SERVER_CONNECTED:String = "server_connected";
		public static const SELECT_USER:String = "select_user";		
		public static const LOGIN_SUCCESS:String = "login_success";
		public static const SELECT_ROOM:String = "select_room";
		public static const SITDOWN_SUCCESS:String = "sitdown_success";
		public static const GAME_NOTIFY:String = "game_notify";
		public static const RESPONSE_PLAY:String = "response_play";
		public static const SELECT_ROB_DEALER_X:String = "select_rob_dealer_x";
		public static const SELECT_BET_X:String = "select_bet_x";
		
		public static const USER_LOGOUT:String = "user_logout";
				
				
		public function NiuNotificationHandlerConstant()
		{
			throw new Error("static abstract class, do not create instance.");
		}
	}
}