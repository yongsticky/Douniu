package view.scene.table.widget
{
	import resource.ResManager;
	
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
			
			
			_playerBankerState = new ExImage(ResManager.instance().getResourceDev("table.dealer"));
			_playerBankerState.x = 140;
			_playerBankerState.y = 30;
			_playerBankerState.visible = false;
			addChild(_playerBankerState);
		}	
		
		
		public function get playerHeader() : Widget_PlayerHeader
		{
			return _playerHeader;
		}
		
		public function get playerCards() : Widget_OtherPlayerCards
		{
			return _playerCards;
		}
		
		public function get playerDealerFlag() : ExImage
		{
			return _playerBankerState;
		}
	}
}