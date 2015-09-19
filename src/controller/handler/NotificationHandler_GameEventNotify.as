package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.GlobalSharedData;
	
	import packet.game.message.Notify.GAME_EVENT_ID;
	import packet.game.message.Notify.Notify_GameEvent;
	import packet.game.message.Notify.TGameEvent;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.value.PlayerDetailInfo;	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_GameTable;
	
	public class NotificationHandler_GameEventNotify extends NiuNotificationHandler
	{
		public function NotificationHandler_GameEventNotify(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
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
				default:
					_logger.log(this, "this event_id[", event.event_id, "] NO MATCH ANY PROCESS HANDLER.", LEVEL.WARNING);
					break;
			}			
		}
		
		private function onEvent_OtherPlayerSitdown(event:TGameEvent) : void
		{
			if (event.room_id != GlobalSharedData.instance().roomId)
			{
				_logger.log(this, "NOT my ROOM event. my room id:[", GlobalSharedData.instance().roomId, "], event room id:[", event.room_id, "].", LEVEL.WARNING);
				return;
			}
			
			if (event.table_id != GlobalSharedData.instance().tableId)
			{
				_logger.log(this, "NOT my TABLE event. my table id:[", GlobalSharedData.instance().tableId, "], event table id:[", event.table_id, "].", LEVEL.WARNING);
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
			var sceneTable:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (sceneTable)
			{
				var layerTable:Layer_GameTable = sceneTable.getChildByNameWithRecursive("table.table") as Layer_GameTable;
				if (layerTable)
				{					
					layerTable.showOtherPlayer(nick, chips, seatId);					
					layerTable.showTimer(8);
				}
			}
		}		
		
		private function onEvent_GameStart(event:TGameEvent) : void
		{
			_logger.log(this, "onEvent_GameStart", LEVEL.INFO);
			
			var sceneTable:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (sceneTable)
			{
				var layerTable:Layer_GameTable = sceneTable.getChildByNameWithRecursive("table.table") as Layer_GameTable;
				if (layerTable)
				{										
					layerTable.hideTimer();				
				}
			}
		}
		
		private function onEvent_GameEnd(event:TGameEvent) : void
		{
			_logger.log(this, "onEvent_GameEnd", LEVEL.INFO);
		}
	}
}