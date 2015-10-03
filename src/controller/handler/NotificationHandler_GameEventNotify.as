package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.RuntimeSharedData;
	
	import packet.game.message.Notify.GAME_EVENT_ID;
	import packet.game.message.Notify.Notify_GameEvent;
	import packet.game.message.Notify.TGameEvent;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.value.ExitPlayerInfo;
	import packet.game.tlv.value.PlayerDetailInfo;
	import packet.game.tlv.value.PlayerMoneyChangeInfo;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_TableMain;
	
	public class NotificationHandler_GameEventNotify extends NiuNotificationHandler
	{
		public function NotificationHandler_GameEventNotify(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var resp:Notify_GameEvent = notification.getData() as Notify_GameEvent;
			
			for (var i:int = 0; i < resp.game_event_num; ++i)
			{
				var event:TGameEvent = resp.game_event_vec[i];
				if (event)
				{
					handleGameEvent(event);
				}
			}
		}
		
		private function handleGameEvent(event:TGameEvent) : void
		{
			if (!checkRoomAndTable(event))
			{
				return;
			}
			
			switch(event.event_id)
			{
				case GAME_EVENT_ID.SITDOWN:
					onEvent_OtherPlayerSitdown(event);
					break;
				case GAME_EVENT_ID.STANDUP:
					onEvent_OtherPlayerStandup(event);
					break;
				case GAME_EVENT_ID.GAME_START:
					onEvent_GameStart(event);
					break;
				case GAME_EVENT_ID.GAME_END:
					onEvent_GameEnd(event);
					break;
				case GAME_EVENT_ID.MONEY_CHANGE:
					onEvent_MoneyChange(event);
					break;			
				default:
					_logger.log(this, "this event_id[", event.event_id, "] NO MATCH ANY PROCESS HANDLER.", LEVEL.WARNING);
					break;
			}			
		}
		
		private function checkRoomAndTable(event:TGameEvent) : Boolean
		{
			if (event.room_id != RuntimeSharedData.instance().rsdRoomData.room_id)
			{
				_logger.log(this, "NOT my ROOM event. my room id:[", RuntimeSharedData.instance().rsdRoomData.room_id, "], event room id:[", event.room_id, "].", LEVEL.WARNING);
				return false;
			}
			
			if (event.table_id != RuntimeSharedData.instance().rsdTableData.table_id)
			{
				_logger.log(this, "NOT my TABLE event. my table id:[", RuntimeSharedData.instance().rsdTableData.table_id, "], event table id:[", event.table_id, "].", LEVEL.WARNING);
				return false;
			}
			
			return true;
		}	
		
		private function onEvent_OtherPlayerSitdown(event:TGameEvent) : void
		{	
			_logger.log(this, "onEvent_OtherPlayerSitdown", LEVEL.INFO);
			
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
			}			
		}
		
		private function onEvent_OtherPlayerStandup(event:TGameEvent) : void
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
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
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
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{					
					layer.hideOtherPlayer(seatId);										
				}
			}
		}
		
		private function onEvent_GameStart(event:TGameEvent) : void
		{
			_logger.log(this, "onEvent_GameStart", LEVEL.DEBUG);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{										
					layer.hideTimer();				
				}
			}
		}
		
		private function onEvent_GameEnd(event:TGameEvent) : void
		{
			_logger.log(this, "onEvent_GameEnd", LEVEL.DEBUG);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{										
					layer.showWaitNextTimer(8);				
				}
			}
		}
		
		private function onEvent_MoneyChange(event:TGameEvent) : void
		{
			_logger.log(this, "onEvent_MoneyChange", LEVEL.DEBUG);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
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