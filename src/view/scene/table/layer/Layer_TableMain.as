package view.scene.table.layer
{	
	import camu.errors.IndexOutOfRangeError;
	
	import global.RuntimeExchangeData;
	
	import view.framework.ExLayer;
	import view.scene.table.cell.OtherPlayer;
	import view.scene.table.cell.Player;
	import view.scene.table.cell.TimerWithText;

	public class Layer_TableMain extends ExLayer
	{		
		private static const MAX_OTHER_PLAYER_NUM:int = 5;	
		
		private var _player:Player;		
		private var _otherPlayers:Vector.<OtherPlayer>;		
		private var _timer:TimerWithText;		
		private var _playerSeatId:int;		
		
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
										
			_timer = new TimerWithText();
			_timer.visible = false;			
			addChild(_timer);
					
		}
		
		override protected function layoutChildren() : void
		{			
			_player.x = (stage.stageWidth - _player.width) /2 ;
			_player.y = stage.stageHeight - _player.height - 60;
			
			_timer.x = (stage.stageWidth - _timer.width)/2;
			_timer.y = (stage.stageHeight - _timer.height - 80)/2;			

			
			var p1:OtherPlayer = _otherPlayers[0];
			p1.x = 40;
			p1.y = (stage.stageHeight - 80) / 3;
			
			var p2:OtherPlayer = _otherPlayers[1];
			p2.x = 40;
			p2.y = (stage.stageHeight - 80) * 2 / 3;
			
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
		
		
		public function showPlayer(name:String, chips:int, seat_id:int = 0) : void
		{
			_playerSeatId = seat_id;
			
			_player.visible = true;
			_player.playerHeader.visible = true;
			
			_player.playerHeader.setPlayerInfo(name, chips, null);			
		}
		
		public function showWaitRobDealerTimer(time:int) : void
		{
			_timer.show(TimerWithText.INDEX_WAIT_ROB_DEALER, time);
		}
		
		public function showWaitBetTimer(time:int) : void
		{
			_timer.show(TimerWithText.INDEX_WAIT_BET, time);
		}
		
		public function showWaitGiveTimer(time:int) : void
		{
			_timer.show(TimerWithText.INDEX_WAIT_GIVE, time);
		}
		
		public function showWaitNextTimer(time:int) : void
		{
			_timer.show(TimerWithText.INDEX_WAIT_NEXT, time);
		}	
		
		public function hideTimer(): void
		{
			_timer.hide();
		}
		
		public function showOtherPlayer(nick:String, chips:int, seatId:int) : void
		{			
			if (seatId >= 0 && seatId < MAX_OTHER_PLAYER_NUM)
			{
				/*var seat:int = seatId - _playerSeatId;
				if (seat < 0)
				{
					seat += MAX_OTHER_PLAYER_NUM;
				}*/
				
				var other:OtherPlayer = getOtherPlayer(seatId); // _otherPlayers[seat-1];
												
				other.visible = true;
				other.playerHeader.setPlayerInfo(nick, chips, 0);
			}
		}
		
		public function hideOtherPlayer(seatId:int) : void
		{
			/*
			if (seatId >= 0 && seatId < MAX_OTHER_PLAYER_NUM)
			{
				var seat:int = seatId - _playerSeatId;
				if (seat < 0)
				{
					seat += MAX_OTHER_PLAYER_NUM;
				}
				
				var other:OtherPlayer = _otherPlayers[seat-1];
				
				
				other.visible = false;				
			}
			*/
			
			getOtherPlayer(seatId).visible = false;			
		}
		
		public function showPlayerReadyButtonGroup() : void
		{
			_player.playerReadyButtonGroup.visible = true;
		}
		
		public function hidePlayerReadyButtonGroup() : void
		{
			_player.playerReadyButtonGroup.visible = false;
		}
		
		public function showRobDealerButtonGroup(x1:int, x2:int, x3:int, x4:int) : void
		{
			_player.playerRobDealerButtonGroup.visible = true;	
		}
		
		public function hideDealerRobButtonGroup() : void
		{
			_player.playerRobDealerButtonGroup.visible = false;
		}
		
		public function setAnyPlayerAsDealer(seatId:int, multiple:int) : void
		{
			// 是自己抢到
			if (seatId == RuntimeExchangeData.instance().redPlayerData.seat_id)
			{
				_player.playerDealerState.visible = true;
			}
			else
			{
				/*
				var seat:int = seatId - RuntimeExchangeData.instance().redPlayerData.seat_id;
				if (seat < 0)
				{
					seat += MAX_OTHER_PLAYER_NUM;
				}
				
				_otherPlayers[seat-1].playerDealerState.visible = true;
				*/
				
				getOtherPlayer(seatId).playerDealerState.visible = true;
			}		
		}
		
		public function clearAnyPlayerAsDealer() : void
		{
			_player.playerDealerState.visible = false;
			
			for each(var other:OtherPlayer in _otherPlayers)
			{
				other.playerDealerState.visible = false;
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
		
		
		public function showBetButtonGroup(x1:int, x2:int, x3:int) : void
		{
			_player.playerBetButtonGroup.setBetMultiple(x1, x2, x3);
			_player.playerBetButtonGroup.visible = true;
		}
		
		public function hideBetButtonGroup() : void
		{
			_player.playerBetButtonGroup.visible = false;
		}
		
		public function showPlayerCards(cards:Vector.<int>) : void
		{			
			_player.playerCards.setPokers(cards);
			_player.playerCards.doGiveAnimation();
			_player.playerCards.visible = true;			
		}
		
		public function updatePlayerCard(index:int, card:int) : void
		{			
			_player.playerCards.updatePoker(index, card);
		}
		
		public function hidePlayerCards() : void
		{
			_player.playerCards.visible = false;
			_player.playerCards.hideAllPokers();
		}
		
		public function showPlayerGiveButtonGroup() : void
		{
			_player.playerGiveButtonGroup.setGiveNiuEnabled(false);
			_player.playerGiveButtonGroup.visible = true;
		}
		
		public function showCardCalculater() : void
		{
			_player.cardCalculater.visible = true;
		}
		
		public function hideCardCalculater() : void
		{
			_player.cardCalculater.visible = false;
		}
		
		public function hidePlayerGiveButtonGroup() : void
		{
			_player.playerGiveButtonGroup.visible = false;
		}
		
		public function showOtherPlayerCards(cards:Vector.<int>, seatId:int = 0) : void
		{
			if (seatId == 0)
			{
				for each(var other:OtherPlayer in _otherPlayers)
				{
					if (other.playerHeader.visible)
					{
						other.playerCards.setPokers(cards);
						other.playerCards.visible = true;
					}
				}
			}
			else
			{				
				/*var seat:int = seatId - _playerSeatId;
				if (seat < 0)
				{
					seat += 5;
				}*/
				
				
				other = getOtherPlayer(seatId);// _otherPlayers[seat-1];
				if (other.playerHeader.visible)
				{
					other.playerCards.setPokers(cards);
					other.playerCards.visible = true;
				}
			}			
		}
		
		public function hideOtherPlayerCards() : void
		{
			for each(var other:OtherPlayer in _otherPlayers)
			{
				if (other.playerHeader.visible)
				{					
					other.playerCards.visible = false;
				}
			}			
		}
		
		public function PlayerMoneyChange(seatId:int, changed:int, current:int) : void
		{				
			if (seatId != _playerSeatId)
			{			
				getOtherPlayer(seatId).playerHeader.setPlayerInfo(null, current, null);				
			}
			else
			{
				_player.playerHeader.setPlayerInfo(null, current, null);	
			}					
		}
		
		private function getOtherPlayer(seatId:int) : OtherPlayer
		{
			var seat:int = seatId - _playerSeatId;
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
				throw new IndexOutOfRangeError();
			}
		}
	}
}