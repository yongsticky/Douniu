package view.scene.table.widget
{
	import resource.ResManager;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_Player extends ExSprite
	{
		private var _playerHeader:Widget_PlayerHeader;						// 玩家头像
		private var _playerCards:Widget_PlayerCards;						// 玩家手牌
		private var _playerReadyButtonGroup:Widget_ReadyButtonGroup;		// 玩家准备操作按钮
		private var _playerReadyState:ExImage;								// 玩家准备状态
		private var _playerRobState:ExImage;								// 玩家抢庄状态
		private var _playerRobButtonGroup:Widget_RobDealerButtonGroup;			// 玩家抢庄倍数操作按钮组
		private var _playerBankerState:ExImage;							// 玩家获得庄家状态		
		private var _playerBetButtonGroup:Widget_BetButtonGroup;			// 玩家押注倍数操作按钮
		private var _playerCommitButtonGroup:Widget_CommitButtonGroup;		// 玩家提交结果按钮组
		private var _playerCommitCalculater:Widget_CommitCalculater;		// 玩家算牛辅助框
		
		
		public function Widget_Player(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_playerHeader = new Widget_PlayerHeader();
			_playerHeader.x = 52;
			_playerHeader.y = 30;
			_playerHeader.visible = false;
			addChild(_playerHeader);
			
			_playerCards = new Widget_PlayerCards();
			_playerCards.x = 220;
			_playerCards.y = 80;
			_playerCards.visible = false;
			_playerCards.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(_playerCards);
			
			
			//_playerReadyButtonGroup = new Widget_ReadyButtonGroup();
			
			
			//_playerReadyState = new ExImage(resManager.getResourceDev(""));
			
			
			_playerRobState = new ExImage(resManager.getResourceDev("table.notify_norob"));
			_playerRobState.x = 120;
			_playerRobState.visible = false;			
			addChild(_playerRobState);
			
			_playerRobButtonGroup = new Widget_RobDealerButtonGroup();
			_playerRobButtonGroup.x = 180;
			_playerRobButtonGroup.y = 0;
			_playerRobButtonGroup.visible = false;
			addChild(_playerRobButtonGroup);
			
			_playerBankerState = new ExImage(resManager.getResourceDev("table.banker"));
			_playerBankerState.x = 0;
			_playerBankerState.y = 60;
			_playerBankerState.visible = false;
			addChild(_playerBankerState);
			
			_playerBetButtonGroup = new Widget_BetButtonGroup();
			_playerBetButtonGroup.x = 180;
			_playerBetButtonGroup.y = 0;
			_playerBetButtonGroup.visible = false;
			addChild(_playerBetButtonGroup);
			
			_playerCommitButtonGroup = new Widget_CommitButtonGroup();
			_playerCommitButtonGroup.visible = false;
			addChild(_playerCommitButtonGroup);
			
			_playerCommitCalculater = new Widget_CommitCalculater();
			_playerCommitCalculater.visible = false;
			addChild(_playerCommitCalculater);			
		}
		
		protected function onTouch(event:TouchEvent) : void
		{			
			var touchObj:Touch = event.getTouch(_playerCards);
			if (touchObj)
			{
				if (touchObj.phase == TouchPhase.ENDED)
				{
					
				}
				
				event.stopImmediatePropagation();
			}
			
						
		}
		
		public function get playerHeader() : Widget_PlayerHeader
		{
			return _playerHeader;
		}
		
		public function get playerCards() : Widget_PlayerCards
		{
			return _playerCards;
		}
		
		public function get playerReadyButtonGroup() : Widget_ReadyButtonGroup
		{
			return _playerReadyButtonGroup;
		}
		
		public function get playerRobButtonGroup() : Widget_RobDealerButtonGroup
		{
			return _playerRobButtonGroup;
		}
		
		public function get playerDealerFlag() : ExImage
		{
			return _playerBankerState;
		}
		
		public function get playerBetButtonGroup() : Widget_BetButtonGroup
		{
			return _playerBetButtonGroup;
		}
		
		public function get playerCommitButtonGroup() : Widget_CommitButtonGroup
		{
			return _playerCommitButtonGroup;
		}
		
		public function get playerCommitCalculater() : Widget_CommitCalculater
		{
			return _playerCommitCalculater;
		}
	}
}