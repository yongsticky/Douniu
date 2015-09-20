package controller.handler
{
	import camu.errors.UnhandledBranchError;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.SharedData;
	
	import packet.game.message.Sitdown.Response_Sitdown;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.value.PlayerDetailInfo;
	
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
			SharedData.instance().tableId = resp.table_id;
			SharedData.instance().seatId = resp.seat_id;
			
			AddPlayer(resp);
			
			
			for each(var tlv:UnionTLV in resp.tlv_vec)
			{
				if (tlv.valueType == TLVType.DN_TLV_TABLE_SIMPLE_INFO)
				{
					
				}
				else if (tlv.valueType == TLVType.DN_TLV_PLAYERDETAIL)
				{
					addOtherPlayer(tlv.value as PlayerDetailInfo);
				}
				else
				{					
					throw new UnhandledBranchError();
				}
			}						
		}
		
		private function AddPlayer(resp:Response_Sitdown) : void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layerTable:Layer_GameTable = scene.getChildByNameWithRecursive("table.table") as Layer_GameTable;
				if (layerTable)
				{
					layerTable.showPlayer(resp.csHeader.uin.toString(), 100000, resp.seat_id);
				}
			}
		}
		
		private function addOtherPlayer(playerDeatil:PlayerDetailInfo) : void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layerTable:Layer_GameTable = scene.getChildByNameWithRecursive("table.table") as Layer_GameTable;
				if (layerTable)
				{
					layerTable.showOtherPlayer(playerDeatil.player_uin.toString(), 100000, playerDeatil.seat_id);
					layerTable.showTimer(8);
				}
			}
		}
	}
}