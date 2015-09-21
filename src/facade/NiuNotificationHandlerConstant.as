package facade
{
	import camu.errors.AbstractClassError;

	public class NiuNotificationHandlerConstant
	{
		public static const STARTUP:String = "handler.startup";		
		public static const SERVER_CONNECTED:String = "handler.server_connected";
		public static const SELECT_USER:String = "handler.select_user";		
		public static const LOGIN_SUCCESS:String = "handler.login_success";
		public static const SELECT_ROOM:String = "handler.select_room";
		public static const SITDOWN_SUCCESS:String = "handler.sitdown_success";
		public static const GAME_NOTIFY:String = "handler.game_notify";
		public static const RESPONSE_PLAY:String = "handler.response_play";
		public static const SELECT_ROB_DEALER_X:String = "handler.select_rob_dealer_x";
		public static const SELECT_BET_X:String = "handler.select_bet_x";
		
		public static const USER_LOGOUT:String = "handler.user_logout";		
		public static const TEST_UI:String = "handler.test_ui";				
				
		public function NiuNotificationHandlerConstant()
		{
			throw new AbstractClassError();			
		}
	}
}