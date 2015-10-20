package view.scene.table.layer
{	
	import global.RuntimeExchangeData;
	
	import resource.ResManager;
	
	import view.framework.ExLayer;
	import view.scene.table.widget.Widget_OtherPlayer;
	import view.scene.table.widget.Widget_Player;
	import view.scene.table.widget.Widget_TimerWithText;

	public class Layer_TableMain extends ExLayer
	{		
		private static const MAX_OTHER_PLAYER_NUM:int = 5;
		
		private static const OTHER_PLAYER_SEAT_POSISTION:Array = [{"x":60, "y":360}, {"x":60, "y":180}, {"x":480, "y":60}, {"x":820, "y":180}, {"x":820, "y":360}];
		
		private var _player:Widget_Player;		
		private var _otherPlayers:Vector.<Widget_OtherPlayer>;		
		private var _timer:Widget_TimerWithText;		
		private var _playerSeatId:int;		
		
		public function Layer_TableMain(name:String = null) 
		{
			super(name);
			
			_otherPlayers = new Vector.<Widget_OtherPlayer>(MAX_OTHER_PLAYER_NUM);
		}
		
		override protected function createChildren() : void
		{			
			_player = new Widget_Player();
			_player.visible = false;
			addChild(_player);
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				var other:Widget_OtherPlayer = new Widget_OtherPlayer(i);
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
			_player.x = 120;
			_player.y = stage.stageHeight - 260;
			
			_timer.x = 510;
			_timer.y = 320;
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				var other:Widget_OtherPlayer = _otherPlayers[i];
				other.x = OTHER_PLAYER_SEAT_POSISTION[i]["x"];
				other.y = OTHER_PLAYER_SEAT_POSISTION[i]["y"];
			}
			
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
			_timer.show(Widget_TimerWithText.INDEX_WAIT_ROB_DEALER, time);
		}
		
		public function showWaitBetTimer(time:int) : void
		{
			_timer.show(Widget_TimerWithText.INDEX_WAIT_BET, time);
		}
		
		public function showWaitGiveTimer(time:int) : void
		{
			_timer.show(Widget_TimerWithText.INDEX_WAIT_GIVE, time);
		}
		
		public function showWaitNextTimer(time:int) : void
		{
			_timer.show(Widget_TimerWithText.INDEX_WAIT_NEXT, time);
		}	
		
		public function hideTimer(): void
		{
			_timer.hide();
		}
		
		public function showOtherPlayer(nick:String, chips:int, seatId:int) : void
		{		
			if (seatId >=0 && seatId < MAX_OTHER_PLAYER_NUM)
			{
				var seat:int = seatId - _playerSeatId;
				if (seat < 0)
				{
					seat += MAX_OTHER_PLAYER_NUM;
				}
				
				var other:Widget_OtherPlayer = _otherPlayers[seat];
												
				other.visible = true;
				other.playerHeader.setPlayerInfo(nick, chips, 0);
			}
		}
		
		public function hideOtherPlayer(seatId:int) : void
		{
			if (seatId >= 0 && seatId < MAX_OTHER_PLAYER_NUM)
			{
				var seat:int = seatId - _playerSeatId;
				if (seat < 0)
				{
					seat += MAX_OTHER_PLAYER_NUM;
				}
				
				var other:Widget_OtherPlayer = _otherPlayers[seat];
				other.visible = false;				
			}
		}
		
		public function showDealerRobButtonGroup(x1:int, x2:int, x3:int, x4:int) : void
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
				var seat:int = seatId - RuntimeExchangeData.instance().redPlayerData.seat_id;
				if (seat < 0)
				{
					seat += MAX_OTHER_PLAYER_NUM;
				}
				
				_otherPlayers[seat].playerDealerState.visible = true;
			}		
		}
		
		public function clearAnyPlayerAsDealer() : void
		{
			_player.playerDealerState.visible = false;
			
			for each(var other:Widget_OtherPlayer in _otherPlayers)
			{
				other.playerDealerState.visible = false;
			}
		}
		public function setAnyPlayerRobDealerState(seatId:int, rob:Boolean) : void
		{
			var resName:String = rob ? "table.notify_rob.png":"table.notify_norob.png";
			
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
				
				var p:Widget_OtherPlayer = _otherPlayers[seat];
				
				p.playerRobDealerState.res = ResManager.instance().getResource(resName);
				p.playerRobDealerState.visible = true;
			}
		}
		
		public function clearAllPlayerRobDealerState() : void
		{
			_player.playerRobDealerState.visible = false;
			
			for each(var p:Widget_OtherPlayer in _otherPlayers)
			{
				p.playerRobDealerState.visible = false;
			}
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
		
		public function hidePlayerGiveButtonGroup() : void
		{
			_player.playerGiveButtonGroup.visible = false;
		}
		
		public function showOtherPlayerCards(cards:Vector.<int>) : void
		{
			for each(var other:Widget_OtherPlayer in _otherPlayers)
			{
				if (other.playerHeader.visible)
				{
					other.playerCards.setPokers(cards);
					other.playerCards.visible = true;
				}
			}
		}
		
		public function hideOtherPlayerCards() : void
		{
			for each(var other:Widget_OtherPlayer in _otherPlayers)
			{
				if (other.playerHeader.visible)
				{					
					other.playerCards.visible = false;
				}
			}			
		}
		
		public function PlayerMoneyChange(seatId:int, changed:int, current:int) : void
		{
			var seat:int = seatId - _playerSeatId;
			if (seat < 0)
			{
				seat += 5;
			}
			
			var player:Widget_OtherPlayer = _otherPlayers[seat];
			
			player.playerHeader.setPlayerInfo(null, current, null);			
		}		
	}
}