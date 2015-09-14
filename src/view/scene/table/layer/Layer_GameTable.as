package view.scene.table.layer
{	
	import douniu.NiuCard;
	
	import global.GlobalSharedData;
	
	import view.framework.ExLayer;
	import view.scene.table.widget.Widget_OtherPlayer;
	import view.scene.table.widget.Widget_Player;
	import view.scene.table.widget.Widget_Timer;

	public class Layer_GameTable extends ExLayer
	{		
		private static const MAX_OTHER_PLAYER_NUM:int = 5;
		
		private static const OTHER_PLAYER_SEAT_POSISTION:Array = [{"x":60, "y":360}, {"x":60, "y":180}, {"x":480, "y":60}, {"x":820, "y":180}, {"x":820, "y":360}];
		
		private var _player:Widget_Player;
		private var _timer:Widget_Timer;
		private var _otherPlayers:Vector.<Widget_OtherPlayer>;
		private var _playerSeatId:int;
		
		
		
		public function Layer_GameTable(name:String = null) 
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
							
			_timer = new Widget_Timer();
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
		
		public function showTimer(time:int) : void
		{			
			_timer.visible = true;			
			_timer.startTimer(time < 10 ? time:9);
		}
		
		public function hideTimer(): void
		{
			_timer.stopTimer();
			_timer.visible = false;			
		}
		
		public function showOtherPlayer(nick:String, chips:int, seat_id:int) : void
		{		
			if (seat_id >=0 && seat_id < MAX_OTHER_PLAYER_NUM)
			{
				var seat:int = seat_id - _playerSeatId;
				if (seat < 0)
				{
					seat += 5;
				}
				
				var other:Widget_OtherPlayer = _otherPlayers[seat];
												
				other.visible = true;
				other.playerHeader.setPlayerInfo(nick, chips, 0);
				other.playerHeader.visible = true;			
			}
		}
		
		public function showDealerRobButtonGroup(x1:int, x2:int, x3:int, x4:int) : void
		{
			_player.playerRobButtonGroup.visible = true;	
		}
		
		public function hideDealerRobButtonGroup() : void
		{
			_player.playerRobButtonGroup.visible = false;
		}
		
		public function setDealerFlag(seat_id:int, multiple:int) : void
		{
			// 是自己抢到
			if (seat_id == GlobalSharedData.instance().seatId)
			{
				_player.playerDealerFlag.visible = true;
			}
			else
			{
				var seat:int = seat_id - GlobalSharedData.instance().seatId;
				if (seat < 0)
				{
					seat += 5;
				}
				
				_otherPlayers[seat].playerDealerFlag.visible = true;
			}
		
		}
		
		public function clearDealerFlag() : void
		{
			_player.playerDealerFlag.visible = false;
			
			for each(var other:Widget_OtherPlayer in _otherPlayers)
			{
				other.playerDealerFlag.visible = false;
			}
		}
		
		public function showBetButtonGroup(x1:int, x2:int, x3:int) : void
		{
			_player.playerBetButtonGroup.visible = true;
		}
		
		public function hideBetButtonGroup() : void
		{
			_player.playerBetButtonGroup.visible = false;
		}
		
		public function showPlayerCards(cards:Vector.<NiuCard>) : void
		{
			_player.playerCards.setPokers(cards);
			_player.playerCards.visible = true;
		}
		
		public function hidePlayerCards() : void
		{
			_player.playerCards.visible = false;
		}
		
		public function showOtherPlayerCards(cards:Vector.<NiuCard>) : void
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
	}
}