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
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.value.ExitPlayerInfo;
	import packet.game.tlv.value.PlayerDetailInfo;
	import packet.game.tlv.value.PlayerMoneyChangeInfo;
	
	import sound.SoundManager;
	
	import view.NiuDirector;
	import view.scene.huanle.Scene_HuanLeTable;
	import view.scene.huanle.layer.Layer_Main;
	import view.scene.table.Scene_Table;
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
			if (event.room_id != RuntimeExchangeData.instance().redRoomData.room_id)
			{
				_logger.log(this, "NOT my ROOM event. my room id:[", RuntimeExchangeData.instance().redRoomData.room_id, "], event room id:[", event.room_id, "].", LEVEL.WARNING);
				return false;
			}
			
			if (event.table_id != RuntimeExchangeData.instance().redTableData.table_id)
			{
				_logger.log(this, "NOT my TABLE event. my table id:[", RuntimeExchangeData.instance().redTableData.table_id, "], event table id:[", event.table_id, "].", LEVEL.WARNING);
				return false;
			}
			
			return true;
		}	
		
		private function onEvent_OtherPlayerSitdown(event:TRoomEvent) : void
		{	
			_logger.log(this, "onEvent_OtherPlayerSitdown", LEVEL.INFO);
			
			if (event.seat_id == RuntimeExchangeData.instance().redPlayerData.seat_id)
			{
				return;
			}
			
			var playerDetail:PlayerDetailInfo = null;
			for each(var tlv:UnionTLV in event.other_info_vec)
			{
				if (tlv.valueType == TLVType.DN_TLV_PLAYERDETAIL)
				{
					playerDetail = tlv.value as PlayerDetailInfo;
					break;
				}
			}
			
			if (playerDetail)
			{
				addPlayerToTable(playerDetail.player_uin.toString(), playerDetail.money.lowPart, playerDetail.seat_id);
				
				SoundManager.instance().playNotifyEnterRoom();
			}			
		}
		
		private function onEvent_OtherPlayerStandup(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_OtherPlayerStandup", LEVEL.INFO);
			
			var exitPlayerInfo:ExitPlayerInfo = null;
			for each(var tlv:UnionTLV in event.other_info_vec)
			{
				if (tlv.valueType == TLVType.DN_TLV_EXIT_PLAYER_INFO)
				{
					exitPlayerInfo = tlv.value as ExitPlayerInfo;
					break;
				}
			}
			
			if (exitPlayerInfo)
			{
				_logger.log(this, "Player Standup, Reason:[",exitPlayerInfo.standup_reason,"]",  LEVEL.INFO);
			}
			 
			removePlayerFromTable(event.seat_id);
		}
		
		private function addPlayerToTable(nick:String, chips:int, seatId:int) : void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByName("table.main") as Layer_TableMain;
				if (layer)
				{					
					layer.showOtherPlayer(nick, chips, seatId);										
				}
			}
		}	
		
		private function removePlayerFromTable(seatId:int) : void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:view.scene.table.layer.Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as view.scene.table.layer.Layer_TableMain;
				if (layer)
				{					
					layer.hideOtherPlayer(seatId);										
				}
			}
		}
		
		private function onEvent_GameStart(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_GameStart", LEVEL.DEBUG);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:view.scene.table.layer.Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as view.scene.table.layer.Layer_TableMain;
				if (layer)
				{	
					layer.hidePlayerCards();					
					layer.hideOtherPlayerCards();
					
					
					layer.hideTimer();
					layer.hidePlayerReadyButtonGroup();					
					
					SoundManager.instance().playNotifyStart();
				}				
			}
		}
		
		private function onEvent_GameEnd(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_GameEnd", LEVEL.DEBUG);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:view.scene.table.layer.Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as view.scene.table.layer.Layer_TableMain;
				if (layer)
				{					
					layer.showPlayerReadyButtonGroup();
					
					layer.showWaitNextGameTimer(8);
				}
			}
			else
			{				
				var scene2:Scene_HuanLeTable = NiuDirector.instance().topScene as Scene_HuanLeTable;
				if (scene2)
				{
					var layer2:Layer_Main = scene2.getChildByName(Scene_HuanLeTable.LAYER_MAIN) as Layer_Main;
					if (layer2)
					{						
						layer2.startNewGame();
					}
				}
			}
		}
		
		private function onEvent_MoneyChange(event:TRoomEvent) : void
		{
			_logger.log(this, "onEvent_MoneyChange", LEVEL.DEBUG);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:view.scene.table.layer.Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as view.scene.table.layer.Layer_TableMain;
				if (layer)
				{
					for each(var tlv:UnionTLV in event.other_info_vec)
					{
						if (tlv.valueType == TLVType.DN_TLV_MONEY_CHANGE_INFO)
						{
							var mcInfo:PlayerMoneyChangeInfo = tlv.value as PlayerMoneyChangeInfo;
							if (mcInfo)
							{
								if (mcInfo.money_change_value.highPart > 0)
								{
									layer.PlayerMoneyChange(event.seat_id,  mcInfo.money_change_value.lowPart, mcInfo.money_cur_value.lowPart);
								}
								else
								{
									layer.PlayerMoneyChange(event.seat_id,  -mcInfo.money_change_value.lowPart, mcInfo.money_cur_value.lowPart);
								}
							}						
						}
					}
				}
			}
		}
		
		
	}
}