package controller.handler
{
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_GameTable;
	
	public class NotificationHandler_PlayerEnter implements INotificationHandler
	{
		public function NotificationHandler_PlayerEnter()
		{
		}
		
		public function execute(notification:Notification):void
		{
			var sceneTable:Scene_Table = NiuDirector.instance().getNamedChildByName("scene.table") as Scene_Table;
			if (sceneTable)
			{
				var layerTable:Layer_GameTable = sceneTable.getNamedChildByName("table.table") as Layer_GameTable;
				if (layerTable)
				{
					layerTable.showPlayer();					
				}
			}
		}
	}
}