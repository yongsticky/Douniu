package controller.handler
{	
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.GlobalSharedData;
	
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
			var logoutReqeust:Request_Logout = NiuObjectFactory.instance().createInstance(Request_Logout);
			
			logoutReqeust.csHeader.uin = GlobalSharedData.instance().uin;
			logoutReqeust.csHeader.dialog_id = GlobalSharedData.instance().playerId;			
			
			logoutReqeust.reason = 0;
			
			NiuRequestSender.instance().sendRequest(logoutReqeust);
			
			NiuDirector.instance().switchToScene(new Scene_Hall());
			
		}
	}
}