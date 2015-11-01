package view.scene.table.cell
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class OtherPlayer extends ExSprite
	{
		private var _seat:int;									// 座位号 从玩家开始 左手边为0 顺时针至4
		
		private var _playerHeader:PlayerHeader;			// 头像信息
		private var _playerCards:OtherPlayerCards;		// 手牌
		private var _playerRobDealerState:ExImage;					// 抢庄状态
		private var _playerRobDealerMultiple:ExImage;				// 抢庄倍数
		private var _playerDealerState:ExImage;				// 庄家状态
		
		
		public function OtherPlayer(seat:int, name:String = null)
		{
			super(name);
			
			_seat = seat;
		}
		
		override protected function createChildren() : void
		{				
			_playerHeader = new PlayerHeader();
			addChild(_playerHeader);
			
			
			_playerCards = new OtherPlayerCards();
			if (_seat > 2)
			{
				_playerCards.x = -160;				
			}
			else
			{
				_playerCards.x = 100;				
			}
			_playerCards.visible = false;
			addChild(_playerCards);
			
			
			_playerDealerState = new ExImage(ResManager.instance().getResource("ui.dealer"));
			_playerDealerState.x = 20;
			_playerDealerState.y = -50;
			_playerDealerState.visible = false;
			addChild(_playerDealerState);
			
			_playerRobDealerState = new ExImage();
			_playerRobDealerState.x = 50;
			_playerRobDealerState.y = -40;
			_playerRobDealerState.visible = false;
			//addChild(_playerRobDealerState);
			
		}	
		
		
		public function get playerHeader() : PlayerHeader
		{
			return _playerHeader;
		}
		
		public function get playerCards() : OtherPlayerCards
		{
			return _playerCards;
		}
		
		public function get playerDealerState() : ExImage
		{
			return _playerDealerState;
		}
		
		public function get playerRobDealerState() : ExImage
		{
			return _playerRobDealerState;
		}
		
		public function get playerRobDealerMultiple() : ExImage
		{
			return _playerRobDealerMultiple;
		}
	}
}