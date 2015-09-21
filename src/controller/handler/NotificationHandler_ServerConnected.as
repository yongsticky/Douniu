package controller.handler
{
	import camu.logger.LEVEL;
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
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			NiuDirector.instance().switchToScene(new Scene_Startup());
		}
	}
}