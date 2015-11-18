package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.RuntimeExchangeData;
	
	import packet.game.message.Notify.Notify_GameEvent;
	import packet.game.message.Notify.ROOM_EVENT_ID;
	import packet.game.message.Notify.TRoomEvent;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.value.ExitPlayerInfo;
	import packet.game.tlv.value.PlayerDetailInfo;
	import packet.game.tlv.value.PlayerMoneyChangeInfo;
	
	import sound.SoundManager;
	
	import view.NiuDirector;
	import view.scene.huanle.Scene_HuanLeTable;
	import view.scene.huanle.layer.Layer_HuanleMain;
	import view.scene.table.Scene_Table;
	import view.scene.table.cell.OtherPlayer;
	import view.scene.table.layer.Layer_TableMain;
	
	public class NotificationHandler_RoomEventNotify extends NiuNotificationHandler
	{
		public function NotificationHandler_RoomEventNotify(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var resp:Notify_GameEvent = notification.getData() as Notify_GameEvent;
			
			for (var i:int = 0; i < resp.game_event_num; ++i)
			{
				var event:TRoomEvent = resp.game_event_vec[i];
				if (event)
				{
					handleGameEvent(event);
				}
			}
		}
		
		private function handleGameEvent(event:TRoomEvent) : void
		{
			if (!checkRoomAndTable(event))
			{
				return;
			}
			
			switch(event.event_id)
			{
				case ROOM_EVENT_ID.SITDOWN:
					onEvent_OtherPlayerSitdown(event);
					break;
				case ROOM_EVENT_ID.STANDUP:
					onEvent_OtherPlayerStandup(event);
					break;
				case ROOM_EVENT_ID.GAME_START:
					onEvent_GameStart(event);
					break;
				case ROOM_EVENT_ID.GAME_END:
					onEvent_GameEnd(event);
					break;
				case ROOM_EVENT_ID.MONEY_CHANGE:
					onEvent_MoneyChange(event);
					break;			
				default:
					_logger.log(this, "this event_id[", event.event_id, "] NO MATCH ANY PROCESS HANDLER.", LEVEL.WARNING);
					break;
			}			
		}
		
		private function checkRoomAndTable(event:TRoomEvent) : Boolean
		{
			var red:RuntimeExchangeData = RuntimeExchangeData.instance();
			if (event.room_id != red.redRoomData.room_id)
			{
				_logger.log(this, "NOT my ROOM event. my room id:[",red.redRoomData.room_id, "], event room id:[", event.room_id, "].", LEVEL.WARNING);
				return false;
			}
			
			if (event.table_id != red.redTableData.table_id)
			{
				_logger.log(this, "NOT my TABLE event. my table id:[", red.redTableData.table_id, "], event table id:[", event.table_id, "].", LEVEL.WARNING);
				return false;
			}
			
			return true;
		}	
		
		private function onEvent_OtherPlayerSitdown(event:TRoomEvent) : void
		{	
			_logger.log(this, "onEvent_OtherPlayerSitdown", LEVEL.INFO);
			
			var red:RuntimeExchangeData = RuntimeExchangeData.instance();
			
			if (event.seat_id == red.redPlayerData.seat_id)
			{
				_logger.log(this, "it's not other player, but myself!", LEVEL.ERROR);
				return;
			}
			
			var playerDetail:PlayerDetailInfo = event.getTLVValue(TLVType.DN_TLV_PLAYERDETAIL) as PlayerDetailInfo;						
			if (playerDetail)
			{	
				++ red.redTableData.player_num; 
				
				var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
				if (layer)
				{					
					var op:OtherPlayer = layer.getOtherPlayer(playerDetail.seat_id);
					if (op)
					{
						op.show(playerDetail.player_uin.toString(), playerDetail.money.lowPart, 0);
					}
					
					layer.getPlayer().showReadyButtonGoroup();
				}
				
				SoundManager.instance().playNotifyEnterRoom();
			}			
		}
		
		private function onEvent_OtherPlayerStandup(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_OtherPlayerStandup", LEVEL.INFO);
			
			
			var exitPlayerInfo:ExitPlayerInfo = event.getTLVValue(TLVType.DN_TLV_EXIT_PLAYER_INFO) as ExitPlayerInfo;
			if (exitPlayerInfo)
			{
				_logger.log(this, "Player Standup, Reason:[",exitPlayerInfo.standup_reason,"]",  LEVEL.INFO);
			}
			
			var red:RuntimeExchangeData = RuntimeExchangeData.instance();
			
			-- red.redTableData.player_num;			
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{	
				var op:OtherPlayer = layer.getOtherPlayer(event.seat_id);
				if (op)
				{
					op.hide();
				}									
			}
		}
		
		private function onEvent_GameStart(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_GameStart", LEVEL.DEBUG);
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;				
			if (layer)
			{								
				layer.getPlayer().hideReadyButtonGroup();				
				layer.hideAllPlayersCards();
				layer.hideAllBetMultiple();
				layer.hideTimer();				
					
				SoundManager.instance().playNotifyStart();
			}
		}
		
		private function onEvent_GameEnd(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_GameEnd", LEVEL.DEBUG);

			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{		
				layer.getPlayer().showReadyButtonGoroup(true);				
			}
			else
			{					
				var layer2:Layer_HuanleMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_HuanLeTable.LAYER_MAIN) as Layer_HuanleMain;
				if (layer2)
				{						
					layer2.startNewGame();
				}
			}
		}
		
		private function onEvent_MoneyChange(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_MoneyChange", LEVEL.DEBUG);
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{
				var mcInfo:PlayerMoneyChangeInfo = event.getTLVValue(TLVType.DN_TLV_MONEY_CHANGE_INFO) as PlayerMoneyChangeInfo;
				if (mcInfo)
				{
					if (event.seat_id == RuntimeExchangeData.instance().redPlayerData.seat_id)
					{
						layer.getPlayer().updateMoney(mcInfo.money_cur_value.lowPart);
					}
					else
					{
						var op:OtherPlayer = layer.getOtherPlayer(event.seat_id);
						if (op)
						{
							op.updateMoney(mcInfo.money_cur_value.lowPart);
						}
					}
				}
			}
		}	
	}
}