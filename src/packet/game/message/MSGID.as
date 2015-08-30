package packet.game.message
{
	public final class MSGID
	{
		
		// Client -> Server
		public static const REQUEST_LOGIN:int = 15801;
		public static const REQUEST_LOGOUT:int = 15802;
		public static const REQUEST_SITDOWN:int = 15803;
		public static const REQUEST_STANDUP:int = 15804;
		public static const REQUEST_READY:int = 15810;


		// Server -> Client
		public static const RESPONSE_WRAPPER_MESSAGE:int = 15814;
		public static const RESPONSE_SITDOWN_FROM_VIEW:int = 15816;
		public static const RESPONSE_VIEW_FROM_SITDOWN:int = 15817;
		
		
		public function MSGID()
		{
			throw new Error("Abstract Class.");
		}
	}
}