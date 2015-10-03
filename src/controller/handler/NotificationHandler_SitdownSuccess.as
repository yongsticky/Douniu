package controller.handler
{
	import camu.errors.UnhandledBranchError;
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.RuntimeSharedData;
	
	import packet.game.message.Sitdown.Response_Sitdown;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.value.PlayerDetailInfo;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_TableMain;
	
	public class NotificationHandler_SitdownSuccess extends NiuNotificationHandler
	{
		public function NotificationHandler_SitdownSuccess(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);			
			
			var resp:Response_Sitdown = notification.getData() as Response_Sitdown;			
			RuntimeSharedData.instance().rsdTableData.table_id = resp.table_id;
			RuntimeSharedData.instance().rsdPlayerData.seat_id = resp.seat_id;
			
			AddPlayer(resp);
			
			for each(var tlv:UnionTLV in resp.tlv_vec)
			{
				if (tlv.valueType == TLVType.DN_TLV_PLAYERDETAIL)
				{
					addOtherPlayer(tlv.value as PlayerDetailInfo);
				}
				else if (tlv.valueType == TLVType.DN_TLV_TABLE_SIMPLE_INFO)
				{
					
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
				var layerTable:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layerTable)
				{					
					layerTable.showPlayer(resp.csHeader.uin.toString(), RuntimeSharedData.instance().rsdPlayerData.chips, resp.seat_id);
				}
			}
		}
		
		private function addOtherPlayer(playerDeatil:PlayerDetailInfo) : void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layerTable:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layerTable)
				{
					layerTable.showOtherPlayer(playerDeatil.player_uin.toString(), playerDeatil.money.lowPart, playerDeatil.seat_id);					
				}
			}
		}
	}
}