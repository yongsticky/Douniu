package view.scene.table.layer
{	
	import camu.errors.IndexOutOfRangeError;
	import camu.logger.LEVEL;
	
	import global.RuntimeExchangeData;
	
	import view.framework.ExLayer;
	import view.scene.table.cell.OtherPlayer;
	import view.scene.table.cell.Player;
	import view.widget.Widget_TimerWithText;

	public class Layer_TableMain extends ExLayer
	{			
		private static const MAX_OTHER_PLAYER_NUM:int = 5;	
		
		private var _player:Player;		
		private var _otherPlayers:Vector.<OtherPlayer>;		
		private var _timer:Widget_TimerWithText;		
		
		public function Layer_TableMain(name:String = null) 
		{
			super(name);
			
			_otherPlayers = new Vector.<OtherPlayer>(MAX_OTHER_PLAYER_NUM);
		}
		
		override protected function createChildren() : void
		{			
			_player = new Player();
			_player.visible = false;
			addChild(_player);
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				var other:OtherPlayer = new OtherPlayer(i);
				_otherPlayers[i] = other;				
				
				other.visible = false;				
				addChild(other);				
			}					
										
			_timer = new Widget_TimerWithText();
			_timer.visible = false;			
			addChild(_timer);
					
		}
		
		override protected function layoutChildren() : void
		{			
			_player.x = (stage.stageWidth - _player.width) /2 ;
			_player.y = stage.stageHeight - _player.height - 60;
			
			_timer.x = (stage.stageWidth - _timer.width)/2;
			_timer.y = (stage.stageHeight - _timer.height - 120)/2;			

			
			var p1:OtherPlayer = _otherPlayers[0];
			p1.x = 40;
			p1.y = (stage.stageHeight - 80) * 2 / 3;
			
			var p2:OtherPlayer = _otherPlayers[1];
			p2.x = 40;
			p2.y = (stage.stageHeight - 80) / 3;
			
			var p3:OtherPlayer = _otherPlayers[2];
			p3.x = (stage.stageWidth - p3.width) * 0.45;
			p3.y = 100;
			
			var p4:OtherPlayer = _otherPlayers[3];
			p4.x = stage.stageWidth - p4.width + 120;
			p4.y = p2.y;
				
			var p5:OtherPlayer = _otherPlayers[4];
			p5.x = p4.x;
			p5.y = p1.y;
			
			
			super.layoutChildren();
		}
		
		public function getPlayer() : Player
		{
			return _player;
		}
		
		public function getOtherPlayer(seatId:int) : OtherPlayer
		{
			if (seatId > MAX_OTHER_PLAYER_NUM)
			{
				return null;
			}
			
			var base:int = RuntimeExchangeData.instance().redPlayerData.seat_id;
						
			if (seatId > base)
			{
				return _otherPlayers[seatId - base - 1];
			}
			else
			{
				return _otherPlayers[seatId - base + MAX_OTHER_PLAYER_NUM];
			}			
		}
		
		public function showWaitRobDealerTimer(time:int) : void
		{
			_timer.show("请抢庄", time);
		}
		
		public function showWaitOtherRobDealerTimer() : void
		{
			_timer.show("等待其他玩家抢庄", 0);
		}
		
		public function showWaitBetTimer(time:int) : void
		{
			_timer.show("请押注", time);
		}
		
		public function showWaitOtherBetTimer() : void
		{
			_timer.show("等待其他玩家押注", 0);
		}
		
		public function showWaitGiveTimer(time:int) : void
		{
			_timer.show("请出牌", time);
		}
		
		public function showWaitOtherGiveTimer() : void
		{
			_timer.show("等待其他玩家出牌", 0);
		}
		
		public function showWaitNextGameTimer(time:int) : void
		{
			_timer.show("游戏即将开始", time);
		}
		
		public function showWaitOtherEnter() : void
		{
			_timer.show("等待其他玩家加入", 0);
		}
		
		public function hideTimer(): void
		{
			_timer.hide();
		}		
			
		public function unsetAllAsDealer() : void
		{
			_player.unsetAsDealer();
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				_otherPlayers[i].unsetAsDealer();
			}
		}
					
		public function hideAllRobDealerNotify() : void
		{
			juggler.delayCall(hideAllRobDealerNotifyDelayFunction, 1);
		}
		
		private function hideAllRobDealerNotifyDelayFunction() : void
		{
			_player.hideRobDealerNotify();
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				if (_otherPlayers[i].visible)
				{
					_otherPlayers[i].hideRobDealerNotify();
				}
			}
		}
		
		public function hideAllBetNotify() : void
		{
			juggler.delayCall(hideAllBetNotifyDelayFunction, 1);	
		}
		
		public function hideAllBetNotifyDelayFunction() : void
		{
			_player.hideBetNotify();
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				if (_otherPlayers[i].visible)
				{
					_otherPlayers[i].hideBetNotify();
				}
			}
		}
		
		public function showAllOtherPlayersCardsNull() : void
		{
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				if (_otherPlayers[i].visible)
				{
					_otherPlayers[i].visible = true;
					_otherPlayers[i].showCards(null);
				}
			}
		}
				
		public function hideAllPlayersCards() : void
		{			
			_player.hideCards();
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				if (_otherPlayers[i].visible)
				{
					_otherPlayers[i].hideCards();
				}
			}			
		}
		
		public function hideAllBetMultiple() : void
		{
			_player.hideBetMultiple();
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				if (_otherPlayers[i].visible)
				{
					_otherPlayers[i].hideBetMultiple();
				}
			}
		}
		
		public function hideAllNiuResult() : void
		{
			juggler.delayCall(hideAllNiuResultDelayFunction, 2);
		}
		
		public function hideAllNiuResultDelayFunction() : void
		{
			_player.hideNiuResult();
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				if (_otherPlayers[i].visible)
				{
					_otherPlayers[i].hideNiuResult();
				}
			}
		}
	}
}