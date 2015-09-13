package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.GlobalInfo;
	
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Sitdown.Request_Sitdown;
	
	import server.NiuHelloHeartBeat;
	import server.NiuRequestSender;
		
	
	public class NotificationHandler_LoginComplete extends NiuNotificationHandler implements INotificationHandler
	{
		public function NotificationHandler_LoginComplete(mediator:Mediator)
		{
			super(mediator);
		}
		
		public function execute(notification:Notification):void
		{			
		}
	}
}