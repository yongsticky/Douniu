package controller.handler
{
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import view.NiuDirector;
	import view.scene.hall.Scene_Hall;
		
	
	public class NotificationHandler_EnterHall implements INotificationHandler
	{
		public function NotificationHandler_EnterHall()
		{
		}
		
		public function execute(notification:Notification):void
		{
			NiuDirector.instance().switchToScene(new Scene_Hall()); 		
		}
	}
}