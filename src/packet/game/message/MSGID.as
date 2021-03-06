package packet.game.message
{
	
	import camu.errors.AbstractClassError;
	import camu.errors.AbstractFunctionError;
	import camu.errors.UnhandledBranchError;
	
	import packet.game.message.Hello.Response_Hello;
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Logout.Response_Logout;
	import packet.game.message.Notify.Notify_DouniuEvent;
	import packet.game.message.Notify.Notify_GameEvent;
	import packet.game.message.Play.Response_Play;
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
		public static const REQUEST_HELLO:int = 15812;


		// Server -> Client
		public static const RESPONSE_LOGIN:int = 15801;
		public static const RESPONSE_LOGOUT:int = 15802;
		public static const RESPONSE_SITDOWN:int = 15803;
		public static const RESPONSE_STANDUP:int = 15804;		
		public static const RESPONSE_READY:int = 15810;
		public static const RESPONSE_PLAY:int = 15813;		
		public static const RESPONSE_HELLO:int = 15812;
		
		public static const NOTIFY_GAMEEVENT:int = 15809;
		public static const NOTIFY_DOUNIUEVENT:int = 15815;

		public static const RESPONSE_WRAPPER_MESSAGE:int = 15814;
		public static const RESPONSE_SITDOWN_FROM_VIEW:int = 15816;
		public static const RESPONSE_VIEW_FROM_SITDOWN:int = 15817;
		
		
		public function MSGID()
		{
			throw new AbstractClassError();			
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
				case NOTIFY_GAMEEVENT:
					return Notify_GameEvent;
				case NOTIFY_DOUNIUEVENT:
					return Notify_DouniuEvent;
				case RESPONSE_HELLO:
					return Response_Hello;
				case RESPONSE_PLAY:
					return Response_Play;
				default:
					throw new UnhandledBranchError("msgId ["+ msgId+"] NOT Match any Response.");					
			}
		}

	}
}