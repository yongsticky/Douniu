package controller.handler
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import camu.errors.NullObjectError;
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import douniu.NiuCard;
	
	import factory.NiuObjectFactory;
	
	import global.SharedData;
	
	import packet.game.message.Notify.Notify_DouniuEvent;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.value.TDealerInfo;
	import packet.game.tlv.value.TTilesInfo;
	import packet.game.tlv.value.TTimerInfo;
	import packet.game.tv.TVType;
	import packet.game.tv.value.NotifyBet;
	import packet.game.tv.value.NotifyBetDetail;
	import packet.game.tv.value.NotifyDealerDetail;
	import packet.game.tv.value.NotifyFinish;
	import packet.game.tv.value.NotifyGive;
	import packet.game.tv.value.NotifyRobDealer;
	import packet.game.tv.value.NotifyStartTimer;
	
	import starling.core.Starling;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_TableMain;
	
	public class NotificationHandler_DouniuEventNotify extends NiuNotificationHandler
	{
		public function NotificationHandler_DouniuEventNotify(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var resp:Notify_DouniuEvent = notification.getData() as Notify_DouniuEvent;
			if (resp && resp.tv_data)
			{					
				switch(resp.tv_data.valueType)
				{
				case TVType.SO_NOTIFY_ROB_DEALER:
					onNotify_RobDealer(resp.tv_data.value as NotifyRobDealer);
					break;
				case TVType.SO_NOTIFY_DEALER_DETAIL:
					onNotify_DealerDetail(resp.tv_data.value as NotifyDealerDetail);	
					break;
				case TVType.SO_NOTIFY_BET:
					onNotify_Bet(resp.tv_data.value as NotifyBet);
					break;
				case TVType.SO_NOTIFY_BET_DETAIL:
					onNotify_BetDetail(resp.tv_data.value as NotifyBetDetail);
					break;
				case TVType.SO_NOTIFY_GIVE:
					onNotify_Give(resp.tv_data.value as NotifyGive);
					break;
				case TVType.SO_NOTIFY_FINISH:
					onNotify_Finish(resp.tv_data.value as NotifyFinish);
					break;
				case TVType.SO_NOTIFY_START_TIMER:
					onNotify_StartTimer(resp.tv_data.value as NotifyStartTimer);
				default:
					_logger.log(this, "NO MATCH TV TTYPE [" + resp.tv_data.valueType + "]", LEVEL.WARNING);
					break;
				}
			}
			else
			{				
				throw new NullObjectError();
			}
				
		}
		
		private function onNotify_RobDealer(v:NotifyRobDealer) : void
		{
			_logger.log(this, "onNotify_RobDealer Enter.", LEVEL.INFO);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{					
					layer.showDealerRobButtonGroup(0, v.multiple[0], v.multiple[1], v.multiple[2]);
					
					var tInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
					if (tInfo)
					{
						layer.showWaitRobDealerTimer(tInfo.time_);
					}					
				}
			}			
		}
		
		private function onNotify_DealerDetail(v:NotifyDealerDetail) : void
		{
			_logger.log(this, "onNotify_DealerDetail Enter.", LEVEL.INFO);	

			
			var dealerInfo:TDealerInfo = v.getTLVValue(TLVType.SO_UP_TLV_DEALER_KEY) as TDealerInfo;
			if (dealerInfo)
			{
				SharedData.instance().dealer = dealerInfo.dealer;	
			}
			else
			{
				return;
			}			
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{					
					layer.hideTimer();
					
					layer.hideDealerRobButtonGroup();
										
					layer.setDealerFlag(v.seat_id, v.multiple);
				}
			}			
		}
		
		private function onNotify_Bet(v:NotifyBet) : void
		{
			_logger.log(this, "onNotify_Bet Enter.", LEVEL.INFO);			
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{
					if (SharedData.instance().dealer != SharedData.instance().seatId)
					{
						layer.showBetButtonGroup(v.multiple[0], v.multiple[1], v.multiple[2]);
					}
					
					var tInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
					if (tInfo)
					{
						layer.showWaitBetTimer(tInfo.time_);	
					}
					
				}
			}
		}
		
		private function onNotify_BetDetail(v:NotifyBetDetail) : void
		{
			_logger.log(this, "onNotify_BetDetail Enter.", LEVEL.INFO);
						
			if (!v.getTLVValue(TLVType.SO_UP_TLV_MULTIPLE_KEY))
			{
				return;
			}		
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{					
					//layer.hideBetButtonGroup();					
				}
			}
						
		}
		
		private function onNotify_Give(v:NotifyGive) : void
		{
			_logger.log(this, "onNotify_Give Enter.", LEVEL.INFO);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{		
					layer.hideTimer();
					layer.hideBetButtonGroup();
					
					var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
					if (tmInfo)
					{
						layer.showWaitGiveTimer(tmInfo.time_);	
					}
					
					
					var tlInfo:TTilesInfo = v.getTLVValue(TLVType.SO_UP_TLV_TILES_KEY) as TTilesInfo;
					if (tlInfo)
					{		
						var vec:Vector.<int> = new <int>[0, 0, 0, 0, 0];
						for (var i:int = 0; i < tlInfo.tiles_num; ++i)
						{
							vec[i] = tlInfo.tiles[i];
						}																								
						layer.showPlayerCards(vec);
						
						
						var vec2:Vector.<int> = new <int>[0, 0, 0, 0, 0];
						layer.showOtherPlayerCards(vec2);
						
						vec.length = 0;
						vec = null;
					}
				}
			}	
			
		}
		
		private function onNotify_Finish(v:NotifyFinish) : void
		{
			_logger.log(this, "onNotify_Finish Enter.", LEVEL.INFO);
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{		
					layer.hidePlayerCards();
					layer.hideOtherPlayerCards();
					layer.hideTimer();
					layer.clearDealerFlag();
					
					SharedData.instance().dealer = -1;					
				}
			}
		}
		
		private function onNotify_StartTimer(v:NotifyStartTimer) : void
		{
			_logger.log(this, "onNotify_StartTimer Enter.", LEVEL.INFO);			
			
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (scene)
			{
				var layer:Layer_TableMain = scene.getChildByNameWithRecursive("table.main") as Layer_TableMain;
				if (layer)
				{	
					if (v.flag == 1)
					{
						var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
						if (tmInfo)
						{							
							layer.showWaitNextTimer(tmInfo.time_);		
						}
					}
					else
					{
						layer.hideTimer();
					}
				}
			}		
		}
	}
}