package view.scene.table.widget
{
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_OtherPlayer extends ExSprite
	{
		private var _seat:int;									// 座位号 从玩家开始 左手边为0 顺时针至4
		
		private var _playerHeader:Widget_PlayerHeader;			// 头像信息
		private var _playerCards:Widget_OtherPlayerCards;		// 手牌
		private var _playerRobState:ExImage;					// 抢庄状态
		private var _playerRobMultiple:ExImage;				// 抢庄倍数
		private var _playerBankerState:ExImage;				// 庄家状态
		
		
		public function Widget_OtherPlayer(seat:int, name:String = null)
		{
			super(name);
			
			_seat = seat;
		}
		
		override protected function createChildren() : void
		{				
			_playerHeader = new Widget_PlayerHeader();
			_playerHeader.visible = false;
			addChild(_playerHeader);
			
			
			_playerCards = new Widget_OtherPlayerCards();
			if (_seat == 2)
			{
				_playerCards.x = 0;
				_playerCards.y = 150;
			}
			else
			{
				_playerCards.x = 120;
				_playerCards.y = 30;
			}
			_playerCards.visible = false;
			addChild(_playerCards);
		}	
		
		
		public function get playerHeader() : Widget_PlayerHeader
		{
			return _playerHeader;
		}
		
		public function get playerCards() : Widget_OtherPlayerCards
		{
			return _playerCards;
		}
	}
}