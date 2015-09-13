package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import controller.NiuNotificationHandler;	
	import global.GlobalInfo;
	
	import view.NiuDirector;
	import view.scene.hall.Scene_Hall;
	
	public class NotificationHandler_SelectUser extends NiuNotificationHandler implements INotificationHandler
	{
		public function NotificationHandler_SelectUser(mediator:Mediator)
		{
			super(mediator);
		}
		
		public function execute(notification:Notification):void
		{
			GlobalInfo.instance().uin = uint(notification.getData());
			
			NiuDirector.instance().switchToScene(new Scene_Hall());			
		}
	}
}