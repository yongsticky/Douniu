package controller.handler
{	
	import camu.errors.NullObjectError;
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.RuntimeExchangeData;
	
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
				layer.showRobDealerButtonGroup(0, v.multiple[0], v.multiple[1], v.multiple[2]);
					
				var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
				if (tmInfo)
				{
					layer.showWaitRobDealerTimer(tmInfo.time_);
				}
					
				// 如果有牌，说明是看牌场
				var tlInfo:TTilesInfo = v.getTLVValue(TLVType.SO_UP_TLV_TILES_KEY) as TTilesInfo;
				if (tlInfo)
				{
					var vec:Vector.<int> = new <int>[0, 0, 0, 0, 0];
					for (var i:int = 0; i < tlInfo.tiles_num; ++i)
					{
						vec[i] = int(tlInfo.tiles[i]);
					}
						
					layer.showPlayerCards(vec);	
					vec.length = 0;
					vec = null;
						
					var vec2:Vector.<int> = new <int>[0, 0, 0, 0, 0];
					layer.showOtherPlayerCards(vec2);
					vec2.length = 0;
					vec2 = null;
						
					SoundManager.instance().playDealCard();
				}
			}			
		}
		
		private function onNotify_DealerDetail(v:NotifyDealerDetail) : void
		{
			_logger.log(this, "onNotify_DealerDetail Enter.", LEVEL.INFO);	
		
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;			
			if (layer)
			{
				var dealerInfo:TDealerInfo = v.getTLVValue(TLVType.SO_UP_TLV_DEALER_KEY) as TDealerInfo;
				if (dealerInfo)
				{
					RuntimeExchangeData.instance().redTableData.dealer_seat_id = dealerInfo.dealer;
					
					layer.hideTimer();				
					layer.hideDealerRobButtonGroup();				
					layer.setAnyPlayerAsDealer(v.seat_id, v.multiple);
					layer.clearAllPlayerRobDealerState();
				}
				else
				{				
					if (v.seat_id == RuntimeExchangeData.instance().redPlayerData.seat_id)
					{
						layer.showWaitOtherRobDealerTimer();
					}
					
					layer.setAnyPlayerRobDealerState(v.seat_id, (v.multiple!=0));
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
					layer.showBetButtonGroup(v.multiple[0], v.multiple[1], v.multiple[2]);						
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
					layer.showWaitOtherBetTimer();
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
				layer.hideBetButtonGroup();
					
				var tmInfo:TTimerInfo = v.getTLVValue(TLVType.SO_UP_TLV_TIMER_KEY) as TTimerInfo;
				if (tmInfo)
				{
					layer.showWaitGiveTimer(tmInfo.time_);	
				}
					
				layer.showCardCalculater();
					
					
				var tlInfo:TTilesInfo = v.getTLVValue(TLVType.SO_UP_TLV_TILES_KEY) as TTilesInfo;
				if (tlInfo)
				{	
					if (tlInfo.tiles_num == 1)
					{
						layer.updatePlayerCard(4, int(tlInfo.tiles[0]));
						layer.showPlayerGiveButtonGroup();						
					}
					else
					{
						var vec:Vector.<int> = new <int>[0, 0, 0, 0, 0];
						for (var i:int = 0; i < tlInfo.tiles_num; ++i)
						{
							vec[i] = tlInfo.tiles[i];
						}																								
						layer.showPlayerCards(vec);
						vec.length = 0;
						vec = null;
													
						var vec2:Vector.<int> = new <int>[0, 0, 0, 0, 0];
						layer.showOtherPlayerCards(vec2);
						vec2.length = 0;
						vec2 = null;	
						
						layer.showPlayerGiveButtonGroup();							
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
				for (var i:int = 0; i < v.finish_info_num; ++i)
				{
					var info:FinishInfo = v.finish_info_vec[i];
					if (info)
					{							
						if (info.seat_id == RuntimeExchangeData.instance().redPlayerData.seat_id)
						{
							if (info.money.highPart > 0)
							{
								SoundManager.instance().playGameWin();
								layer.getPlayer().setMoneyChange(info.money.lowPart);
							}
							else
							{
								SoundManager.instance().playGameLose();
								layer.getPlayer().setMoneyChange(0-info.money.lowPart);
							}							
						}
						else
						{
							var cards:Vector.<int> = new <int>[0, 0, 0, 0, 0];
							for (var j:int = 0; j < info.tiles_num; ++j)
							{
								cards[j] = int(info.tiles[j]);
								layer.showOtherPlayerCards(cards, info.seat_id);
								
								layer.getOtherPlayer(info.seat_id).setMoneyChange(info.money.lowPart);
							}							
						}
					}					
				}
												
				
				layer.hideCardCalculater();					
				layer.hidePlayerGiveButtonGroup();					
				layer.clearAnyPlayerAsDealer();
					
				layer.hideTimer();					
					
				RuntimeExchangeData.instance().redTableData.dealer_seat_id = -1;					
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