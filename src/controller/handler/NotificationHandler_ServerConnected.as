package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import controller.NiuNotificationHandler;	
	import view.NiuDirector;
	import view.scene.startup.Scene_Startup;
	
	public class NotificationHandler_ServerConnected extends NiuNotificationHandler implements INotificationHandler
	{
		public function NotificationHandler_ServerConnected(mediator:Mediator)
		{
			super(mediator);
		}
		
		public function execute(notification:Notification):void
		{
			NiuDirector.instance().switchToScene(new Scene_Startup());
		}
	}
}