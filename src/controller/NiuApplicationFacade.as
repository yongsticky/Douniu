package controller 
{
	import camu.mvc.Facade;
	
	import controller.handler.NotificationHandler_EnterHall;
	import controller.handler.NotificationHandler_EnterRoom;
	import controller.handler.NotificationHandler_OtherPlayerEnter;
	import controller.handler.NotificationHandler_OtherPlayerLeave;
	import controller.handler.NotificationHandler_OtherPlayerReady;
	import controller.handler.NotificationHandler_PlayerEnter;
	import controller.handler.NotificationHandler_PlayerLeave;
	
	public class NiuApplicationFacade extends Facade
	{
		public function NiuApplicationFacade(inner:PrivateInner)
		{
			super();
		}
		
		private static var _instance:NiuApplicationFacade;
		public static function instance() : NiuApplicationFacade
		{
			if (!_instance)
			{
				_instance = new NiuApplicationFacade(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function initializeNotificationHandlers() : void
		{
			registerHandler(NiuHandlerConstant.ENTER_HALL, new NotificationHandler_EnterHall());
			registerHandler(NiuHandlerConstant.ENTER_ROOM, new NotificationHandler_EnterRoom());
			registerHandler(NiuHandlerConstant.PLAYER_ENTER, new NotificationHandler_PlayerEnter());
			registerHandler(NiuHandlerConstant.PLAYER_LEAVE, new NotificationHandler_PlayerLeave());
			registerHandler(NiuHandlerConstant.OTHERPLAYER_ENTER, new NotificationHandler_OtherPlayerEnter());
			registerHandler(NiuHandlerConstant.OTHERPLAYER_LEAVE, new NotificationHandler_OtherPlayerLeave());
			registerHandler(NiuHandlerConstant.OTHERPLAYER_READY, new NotificationHandler_OtherPlayerReady());
		}
	}
}

class PrivateInner
{
	
}