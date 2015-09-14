package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.GlobalSharedData;
	
	import view.NiuDirector;
	import view.scene.hall.Scene_Hall;
	
	public class NotificationHandler_SelectUser extends NiuNotificationHandler
	{
		public function NotificationHandler_SelectUser(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			GlobalSharedData.instance().uin = uint(notification.getData());
			
			_logger.log(this, "User select User:[", uint(notification.getData()), "]", LEVEL.INFO);
			
			NiuDirector.instance().switchToScene(new Scene_Hall());			
		}
	}
}