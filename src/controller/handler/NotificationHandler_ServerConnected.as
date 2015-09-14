package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
		
	import controller.NiuNotificationHandler;	
	import view.NiuDirector;
	import view.scene.startup.Scene_Startup;
	
	public class NotificationHandler_ServerConnected extends NiuNotificationHandler
	{
		public function NotificationHandler_ServerConnected(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			NiuDirector.instance().switchToScene(new Scene_Startup());
		}
	}
}