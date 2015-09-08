package packet.game.message
{
	
	import packet.game.message.Login.Response_Login;	
	import packet.game.message.Logout.Response_Logout;
	import packet.game.message.Notify.Response_GameNotify;	
	import packet.game.message.Ready.Response_Ready;	
	import packet.game.message.Sitdown.Response_Sitdown;	
	import packet.game.message.Standup.Response_Standup;
	import packet.game.message.WrapperMessage.Response_WrapperMessage;

	public final class MSGID
	{
		
		// Client -> Server
		public static const REQUEST_LOGIN:int = 15801;
		public static const REQUEST_LOGOUT:int = 15802;
		public static const REQUEST_SITDOWN:int = 15803;
		public static const REQUEST_STANDUP:int = 15804;
		public static const REQUEST_READY:int = 15810;
		public static const REQUEST_PLAY:int = 15813;


		// Server -> Client
		public static const RESPONSE_LOGIN:int = 15801;
		public static const RESPONSE_LOGOUT:int = 15802;
		public static const RESPONSE_SITDOWN:int = 15803;
		public static const RESPONSE_STANDUP:int = 15804;
		public static const RESPONSE_GAMEEVENT:int = 15809;
		public static const RESPONSE_READY:int = 15810;

		public static const RESPONSE_WRAPPER_MESSAGE:int = 15814;
		public static const RESPONSE_SITDOWN_FROM_VIEW:int = 15816;
		public static const RESPONSE_VIEW_FROM_SITDOWN:int = 15817;
		
		
		public function MSGID()
		{
			throw new Error("Abstract Class.");
		}
		
		public static function MSGID_TO_CLASS(msgId:int) : Class
		{
			switch(msgId)
			{
				case RESPONSE_WRAPPER_MESSAGE:
					return Response_WrapperMessage;
				case RESPONSE_LOGIN:
					return Response_Login;
				case RESPONSE_LOGOUT:
					return Response_Logout; 
				case RESPONSE_SITDOWN:
					return Response_Sitdown;
				case RESPONSE_STANDUP:
					return Response_Standup;
				case RESPONSE_READY:
					return Response_Ready;	
				case RESPONSE_GAMEEVENT:
					return Response_GameNotify;
				default:
					throw new Error("msgId ["+ msgId+"] NOT Match any Response.");					
			}
		}

	}
}