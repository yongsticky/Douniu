package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.GlobalSharedData;
	
	import packet.game.message.Sitdown.Response_Sitdown;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_GameTable;
	
	public class NotificationHandler_SitdownSuccess extends NiuNotificationHandler
	{
		public function NotificationHandler_SitdownSuccess(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			var resp:Response_Sitdown = notification.getData() as Response_Sitdown;
			
			GlobalSharedData.instance().tableId = resp.table_id;			
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layerTable:Layer_GameTable = scene.getNamedChildByName("table.table") as Layer_GameTable;
				if (layerTable)
				{
					layerTable.showPlayer(GlobalSharedData.instance().uin.toString(), 10000);					
				}
			}
		}
	}
}