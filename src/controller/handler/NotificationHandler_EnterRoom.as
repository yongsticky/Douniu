package controller.handler
{
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import controller.NiuHandlerConstant;	
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	
	public class NotificationHandler_EnterRoom implements INotificationHandler
	{
		public function NotificationHandler_EnterRoom()
		{
		}
		
		public function execute(notification:Notification):void
		{
			var rid:int = notification.getData().rid;
			
			var sceneTable:Scene_Table = new Scene_Table("scene.table");
			NiuDirector.instance().switchToScene(sceneTable);
			
			NiuDirector.instance().sendNotification(NiuHandlerConstant.PLAYER_ENTER, null);
			
		}
	}
}