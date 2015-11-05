package controller.handler
{
	import camu.errors.UnhandledBranchError;
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.RuntimeExchangeData;
	
	import packet.game.message.Sitdown.Response_Sitdown;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.value.PlayerDetailInfo;
	import packet.game.tlv.value.TableSimpleInfo;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.cell.OtherPlayer;
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
			if (!resp || resp.rresult.result_id != 0)
			{
				_logger.log(this, "Sitdown failed.", LEVEL.ERROR);
				return;
			}
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{
				RuntimeExchangeData.instance().redTableData.table_id = resp.table_id;
				RuntimeExchangeData.instance().redPlayerData.seat_id = resp.seat_id;
				
				layer.getPlayer().show(resp.csHeader.uin.toString(), RuntimeExchangeData.instance().redPlayerData.money, 0);				
		
				layer.getPlayer().showReadyButtonGoroup();
				layer.showWaitOtherEnter();	
								
				for (var i:int = 0; i < resp.tlv_num; ++i)				
				{
					var tlv:UnionTLV = resp.tlv_vec[i];
					if (tlv.valueType == TLVType.DN_TLV_PLAYERDETAIL)
					{
						var v:PlayerDetailInfo = tlv.value as PlayerDetailInfo;						
						var op:OtherPlayer = layer.getOtherPlayer(v.seat_id);
						if (op)
						{
							op.show(v.player_uin.toString(), v.money.lowPart, 0);
						}
					}
					else if (tlv.valueType == TLVType.DN_TLV_TABLE_SIMPLE_INFO)
					{
						var tsInfo:TableSimpleInfo = tlv.value as TableSimpleInfo;
						if (tsInfo)
						{
							RuntimeExchangeData.instance().redTableData.player_num = tsInfo.cur_player_num;
						}
					}
					else
					{					
						throw new UnhandledBranchError();
					}
				}		
			}						
		}
	}
}