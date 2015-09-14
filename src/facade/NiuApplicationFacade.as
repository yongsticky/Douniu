package facade 
{
	import camu.mvc.Facade;
	
	import controller.NiuControllerMediator;
	import controller.NiuNotificationHandlerConstant;
	import controller.handler.NotificationHandler_GameNotify;
	import controller.handler.NotificationHandler_LoginSuccess;
	import controller.handler.NotificationHandler_OtherPlayerEnter;
	import controller.handler.NotificationHandler_PlayerEnter;
	import controller.handler.NotificationHandler_SelectRoom;
	import controller.handler.NotificationHandler_SelectUser;
	import controller.handler.NotificationHandler_ServerConnected;
	import controller.handler.NotificationHandler_SitdownSuccess;
	import controller.handler.NotificationHandler_Startup;
	
	public class NiuApplicationFacade extends Facade
	{
		private var _mediator:NiuControllerMediator;
		
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
			_mediator = new NiuControllerMediator();
			
			registerHandler(NiuNotificationHandlerConstant.STARTUP, new NotificationHandler_Startup(_mediator));			
			registerHandler(NiuNotificationHandlerConstant.SERVER_CONNECTED, new NotificationHandler_ServerConnected(_mediator));	
			registerHandler(NiuNotificationHandlerConstant.SELECT_USER, new NotificationHandler_SelectUser(_mediator));
			registerHandler(NiuNotificationHandlerConstant.LOGIN_SUCCESS, new NotificationHandler_LoginSuccess(_mediator));
			registerHandler(NiuNotificationHandlerConstant.SELECT_ROOM, new NotificationHandler_SelectRoom(_mediator));
			registerHandler(NiuNotificationHandlerConstant.SITDOWN_SUCCESS, new NotificationHandler_SitdownSuccess(_mediator));
			registerHandler(NiuNotificationHandlerConstant.GAME_NOTIFY, new NotificationHandler_GameNotify(_mediator));			
			
			
			registerHandler(NiuNotificationHandlerConstant.PLAYER_ENTER, new NotificationHandler_PlayerEnter(_mediator));			
			registerHandler(NiuNotificationHandlerConstant.OTHERPLAYER_ENTER, new NotificationHandler_OtherPlayerEnter(_mediator));			
		}
	}
}

class PrivateInner
{
	
}