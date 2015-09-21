package facade 
{
	import camu.mvc.Facade;
		
	import controller.handler.NotificationHandler_DouniuEventNotify;
	import controller.handler.NotificationHandler_GameEventNotify;
	import controller.handler.NotificationHandler_LoginSuccess;
	import controller.handler.NotificationHandler_SelectBetX;
	import controller.handler.NotificationHandler_SelectRobDealerX;
	import controller.handler.NotificationHandler_SelectRoom;
	import controller.handler.NotificationHandler_SelectUser;
	import controller.handler.NotificationHandler_ServerConnected;
	import controller.handler.NotificationHandler_SitdownSuccess;
	import controller.handler.NotificationHandler_Startup;
	import controller.handler.NotificationHandler_TestUI;
	import controller.handler.NotificationHandler_UserLogout;
	import controller.NiuControllerMediator;
	
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
			registerHandler(NiuNotificationHandlerConstant.GAME_NOTIFY, new NotificationHandler_GameEventNotify(_mediator));
			registerHandler(NiuNotificationHandlerConstant.RESPONSE_PLAY, new NotificationHandler_DouniuEventNotify(_mediator));
			registerHandler(NiuNotificationHandlerConstant.SELECT_ROB_DEALER_X, new NotificationHandler_SelectRobDealerX(_mediator));
			registerHandler(NiuNotificationHandlerConstant.SELECT_BET_X, new NotificationHandler_SelectBetX(_mediator));
			
						
			registerHandler(NiuNotificationHandlerConstant.USER_LOGOUT, new NotificationHandler_UserLogout(_mediator));
			
			registerHandler(NiuNotificationHandlerConstant.TEST_UI, new NotificationHandler_TestUI(_mediator));
		}	
	}
}

class PrivateInner
{
	
}