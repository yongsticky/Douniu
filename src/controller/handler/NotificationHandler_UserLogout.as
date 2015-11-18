package controller.handler
{	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.RuntimeExchangeData;
	import global.structs.REDPlayerData;
	
	import packet.game.message.Logout.Request_Logout;
	
	import server.NiuRequestSender;
	
	import view.NiuDirector;
	import view.scene.hall.Scene_Hall;
	
	public class NotificationHandler_UserLogout extends NiuNotificationHandler
	{
		public function NotificationHandler_UserLogout(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{	
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var logoutReqeust:Request_Logout = NiuObjectFactory.instance().createInstance(Request_Logout);
						
			var redp:REDPlayerData = RuntimeExchangeData.instance().redPlayerData;
			logoutReqeust.csHeader.uin = redp.uin;
			logoutReqeust.csHeader.dialog_id = redp.player_id;			
			
			logoutReqeust.reason = 0;
			
			NiuRequestSender.instance().sendRequest(logoutReqeust);
			
			NiuDirector.instance().switchToScene(new Scene_Hall());
			
		}
	}
}