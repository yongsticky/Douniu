package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.SharedData;
	
	import packet.game.message.Notify.GAME_EVENT_ID;
	import packet.game.message.Notify.Notify_GameEvent;
	import packet.game.message.Notify.TGameEvent;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
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
			switch(event.event_id)
			{
				case GAME_EVENT_ID.SITDOWN:
					onEvent_OtherPlayerSitdown(event);
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
		
		private function onEvent_OtherPlayerSitdown(event:TGameEvent) : void
		{
			if (event.room_id != SharedData.instance().roomId)
			{
				_logger.log(this, "NOT my ROOM event. my room id:[", SharedData.instance().roomId, "], event room id:[", event.room_id, "].", LEVEL.WARNING);
				return;
			}
			
			if (event.table_id != SharedData.instance().tableId)
			{
				_logger.log(this, "NOT my TABLE event. my table id:[", SharedData.instance().tableId, "], event table id:[", event.table_id, "].", LEVEL.WARNING);
				return;
			}
			
			var playerDetail:PlayerDetailInfo = null;
			for each(var tlv:UnionTLV in event.other_info_vec)
			{
				_logger.log(this, "check tlv type:", tlv.valueType, LEVEL.DEBUG);
				if (tlv.valueType == TLVType.DN_TLV_PLAYERDETAIL)
				{
					playerDetail = tlv.value as PlayerDetailInfo;
					break;
				}
			}
			
			if (playerDetail)
			{
				addPlayerToTableAndWaitStart(playerDetail.player_uin.toString(), playerDetail.money.lowPart, playerDetail.seat_id);						
			}			
		}
		
		private function addPlayerToTableAndWaitStart(nick:String, chips:int, seatId:int) : void
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