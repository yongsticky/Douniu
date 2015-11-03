package view.scene.table.layer
{	
	import camu.errors.IndexOutOfRangeError;
	import camu.logger.LEVEL;
	
	import global.RuntimeExchangeData;
	
	import starling.filters.BlurFilter;
	
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
			var seat:int = seatId - RuntimeExchangeData.instance().redPlayerData.seat_id;
			if (seat < 0)
			{
				seat += MAX_OTHER_PLAYER_NUM;
			}
			
			if (seat > 0)
			{
				return _otherPlayers[seat-1];
			}
			else
			{		
				_logger.log(this, "seat=",seat, LEVEL.ERROR);
				throw new IndexOutOfRangeError();
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
		
		/*
		public function showPlayerReadyButtonGroup() : void
		{
			if (_player.playerCards.visible)
			{
				_player.playerCards.filter = new BlurFilter();				
			}
			
			_player.playerReadyButtonGroup.visible = true;
		}
		
		
		public function hidePlayerReadyButtonGroup() : void
		{
			_player.playerCards.filter = null;		
			
			_player.playerReadyButtonGroup.visible = false;
		}
		*/		
		
		public function unsetAllAsDealer() : void
		{
			_player.unsetAsDealer();
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				_otherPlayers[i].unsetAsDealer();
			}
		}
		
		
		
		public function setAnyPlayerRobDealerState(seatId:int, rob:Boolean) : void
		{		
			/*
			var resName:String = rob ? "ui.bet_text_bg":"ui.no_rob_dealer";
			
			if (seatId == RuntimeExchangeData.instance().redPlayerData.seat_id)
			{
				_player.playerRobDealerState.res = ResManager.instance().getResource(resName);
				_player.playerRobDealerState.visible = true;
			}
			else
			{
				var seat:int = seatId - RuntimeExchangeData.instance().redPlayerData.seat_id;
				if (seat < 0)
				{
					seat += MAX_OTHER_PLAYER_NUM;
				}
				
				var p:OtherPlayer = _otherPlayers[seat];
				
				p.playerRobDealerState.res = ResManager.instance().getResource(resName);
				p.playerRobDealerState.visible = true;
			}
			*/
		}
		
		public function clearAllPlayerRobDealerState() : void
		{
			/*
			_player.playerRobDealerState.visible = false;
			
			for each(var p:OtherPlayer in _otherPlayers)
			{
				p.playerRobDealerState.visible = false;
			}
			*/
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
				
		public function hideAllOtherPlayersCards() : void
		{
			for each(var other:OtherPlayer in _otherPlayers)
			{
				if (other.playerHeader.visible)
				{					
					other.playerCards.visible = false;
				}
			}			
		}
		
		/*
		public function PlayerMoneyChange(seatId:int, changed:int, current:int) : void
		{				
			if (seatId != RuntimeExchangeData.instance().redPlayerData.seat_id)
			{			
				getOtherPlayer(seatId).playerHeader.setPlayerInfo(null, current, null);				
			}
			else
			{
				_player.playerHeader.setPlayerInfo(null, current, null);	
			}					
		}
		*/
		
	}
}