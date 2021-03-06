package controller.handler
{	
	import camu.errors.NullObjectError;
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import douniu.NiuSuggest;
	import douniu.NiuType;
	
	import global.RuntimeExchangeData;
	import global.structs.REDPlayerData;
	
	import packet.game.message.Notify.Notify_DouniuEvent;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.value.TDealerInfo;
	import packet.game.tlv.value.TTilesInfo;
	import packet.game.tlv.value.TTimerInfo;
	import packet.game.tv.TVType;
	import packet.game.tv.value.FinishInfo;
	import packet.game.tv.value.NotifyBet;
	import packet.game.tv.value.NotifyBetDetail;
	import packet.game.tv.value.NotifyDealerDetail;
	import packet.game.tv.value.NotifyFinish;
	import packet.game.tv.value.NotifyGive;
	import packet.game.tv.value.NotifyRobDealer;
	import packet.game.tv.value.NotifyStartTimer;
	
	import sound.SoundManager;
	
	import view.NiuDirector;
	import view.scene.huanle.Scene_HuanLeTable;
	import view.scene.huanle.layer.Layer_HuanleMain;
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
					onNotify_RobDealerDetail(resp.tv_data.value as NotifyDealerDetail);	
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
					break;
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
						
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{	
				layer.getPlayer().showRobDealerButtonGroup(v.multiple[0], v.multiple[1], v.multiple[2]);
					
				var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
				if (tmInfo)
				{
					layer.showWaitRobDealerTimer(tmInfo.time_);
				}
					
				// 如果有牌，说明是看牌场
				var tlInfo:TTilesInfo = v.getTLVValue(TLVType.SO_UP_TLV_TILES_KEY) as TTilesInfo;
				if (tlInfo)
				{				
					layer.getPlayer().showCards(tlInfo.tiles);											
					layer.showAllOtherPlayersCardsNull();
					
					SoundManager.instance().playDealCard();
				}
			}			
		}
		
		private function onNotify_RobDealerDetail(v:NotifyDealerDetail) : void
		{
			_logger.log(this, "onNotify_RobDealerDetail Enter.", LEVEL.INFO);	
		
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;			
			if (layer)
			{
				var red:RuntimeExchangeData = RuntimeExchangeData.instance();
				var redp:REDPlayerData = red.redPlayerData;
				var dealerInfo:TDealerInfo = v.getTLVValue(TLVType.SO_UP_TLV_DEALER_KEY) as TDealerInfo;
				if (dealerInfo)
				{
					red.redTableData.dealer_seat_id = dealerInfo.dealer;
					
					layer.hideTimer();				
					layer.getPlayer().hideRobDealerButtonGroup();			
					
					
					if (dealerInfo.dealer == redp.seat_id)
					{
						layer.getPlayer().setAsDealer();
					}
					else
					{
						layer.getOtherPlayer(dealerInfo.dealer).setAsDealer();
					}					
					
					layer.hideAllRobDealerNotify();
				}
				else
				{				
					if (v.seat_id ==redp.seat_id)
					{
						layer.showWaitOtherRobDealerTimer();
						layer.getPlayer().showRobDealerNotify(v.multiple>0);
					}
					else
					{
						layer.getOtherPlayer(v.seat_id).showRobDealerNotify(v.multiple>0);
					}				
				}
			}				
		}
		
		private function onNotify_Bet(v:NotifyBet) : void
		{
			_logger.log(this, "onNotify_Bet Enter.", LEVEL.INFO);			
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{					
				var tInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
				if (tInfo)
				{
					layer.showWaitBetTimer(tInfo.time_);	
				}
					
				var red:RuntimeExchangeData = RuntimeExchangeData.instance(); 
				if (red.redTableData.dealer_seat_id != red.redPlayerData.seat_id)
				{
					layer.getPlayer().showBetButtonGroup(v.multiple[0], v.multiple[1], v.multiple[2]);					
				}
				else
				{
					layer.showWaitOtherBetTimer();
				}					
			}
		}
		
		private function onNotify_BetDetail(v:NotifyBetDetail) : void
		{
			_logger.log(this, "onNotify_BetDetail Enter.", LEVEL.INFO);	
			
			SoundManager.instance().playNotifyBetDetail();
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{
				if (v.seat_id == RuntimeExchangeData.instance().redPlayerData.seat_id)
				{
					layer.getPlayer().showBetNotify(v.multiple);
					layer.getPlayer().showBetMultiple(v.multiple);
					
					layer.showWaitOtherBetTimer();
				}
				else
				{
					layer.getOtherPlayer(v.seat_id).showBetNotify(v.multiple);
					layer.getOtherPlayer(v.seat_id).showBetMultiple(v.multiple);
				}
			}			
			else
			{
				var layer2:Layer_HuanleMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_HuanLeTable.LAYER_MAIN) as Layer_HuanleMain;
				if (layer2)
				{	
					var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
					if (tmInfo)
					{
						layer2.showTimer(tmInfo.time_);						
					}				
				}
			}						
		}
		
		private function onNotify_Give(v:NotifyGive) : void
		{
			_logger.log(this, "onNotify_Give Enter.", LEVEL.INFO);			
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{		
				layer.hideTimer();
				layer.getPlayer().hideBetButtonGroup();
				layer.hideAllBetNotify();
					
				var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
				if (tmInfo)
				{
					layer.showWaitGiveTimer(tmInfo.time_);	
				}
					
				layer.getPlayer().showAssistCalculater();
					
					
				var tlInfo:TTilesInfo = v.getTLVValue(TLVType.SO_UP_TLV_TILES_KEY) as TTilesInfo;
				if (tlInfo)
				{	
					if (tlInfo.tiles_num == 1)
					{	
						layer.getPlayer().setCard(4, int(tlInfo.tiles[0]));						
						layer.getPlayer().showGiveButtonGroup();						
					}
					else
					{																				
						layer.getPlayer().showCards(tlInfo.tiles);													
						layer.showAllOtherPlayersCardsNull();
						
						layer.getPlayer().showGiveButtonGroup();						
					}
					
					SoundManager.instance().playGiveCard();
				}
			}	
		}
		
		private function onNotify_Finish(v:NotifyFinish) : void
		{
			_logger.log(this, "onNotify_Finish Enter.", LEVEL.INFO);			
						
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{		
				var red:RuntimeExchangeData = RuntimeExchangeData.instance();
				for (var i:int = 0; i < v.finish_info_num; ++i)
				{
					var info:FinishInfo = v.finish_info_vec[i];
					if (info)
					{							
						if (info.seat_id == red.redPlayerData.seat_id)
						{	
							layer.getPlayer().showNiuResult(NiuSuggest.getSuggestObject(info.tiles)["niuType"]);
							
							if (info.money.highPart > 0)
							{
								SoundManager.instance().playGameWin();
								layer.getPlayer().flowMoneyChangeText(info.money.lowPart);
							}
							else
							{
								SoundManager.instance().playGameLose();
								layer.getPlayer().flowMoneyChangeText(0-info.money.lowPart);
							}							
						}
						else
						{	
							layer.getOtherPlayer(info.seat_id).showNiuResult(NiuSuggest.getSuggestObject(info.tiles)["niuType"]);
							
							layer.getOtherPlayer(info.seat_id).showCards(info.tiles);							
							layer.getOtherPlayer(info.seat_id).flowMoneyChangeText(info.money.lowPart);							
						}
					}					
				}

				layer.getPlayer().hideAssistCalculater();
				layer.getPlayer().hideGiveButtonGroup();			
				layer.unsetAllAsDealer();					
				layer.hideTimer();			
					
				red.redTableData.dealer_seat_id = -1;					
			}
			else
			{				
				var layer2:Layer_HuanleMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_HuanLeTable.LAYER_MAIN) as Layer_HuanleMain;
				if (layer2)
				{
					var vec:Vector.<FinishInfo> = new Vector.<FinishInfo>(v.finish_info_num);
					for (var k:int = 0; k < v.finish_info_num; ++k)
					{
						var info2:FinishInfo = v.finish_info_vec[k];
						if (info2)
						{
							vec[k] = info2;
						}
					}
					
					layer2.hideTimer();
					layer2.updatePokers(vec);
				}
			}
		}
		
		private function onNotify_StartTimer(v:NotifyStartTimer) : void
		{
			_logger.log(this, "onNotify_StartTimer Enter.", LEVEL.INFO);
			
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{	
				if (v.flag == 1)
				{
					var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
					if (tmInfo)
					{							
						layer.showWaitNextGameTimer(tmInfo.time_);
						layer.getPlayer().showReadyButtonGoroup(true);
					}
				}
				else
				{
					layer.getPlayer().showReadyButtonGoroup();
					layer.hideTimer();
				}
			}		
		}
	}
}