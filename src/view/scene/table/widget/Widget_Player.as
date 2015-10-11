package view.scene.table.widget
{	
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_Player extends ExSprite
	{
		private var _playerHeader:Widget_PlayerHeader;						// 玩家头像
		private var _playerCards:Widget_PlayerCards;						// 玩家手牌

		private var _playerRobDealerState:ExImage;								// 玩家抢庄状态
		private var _playerDealerState:ExImage;							// 玩家获得庄家状态
		private var _playerRobDealerButtonGroup:Widget_RobDealerButtonGroup;			// 玩家抢庄倍数操作按钮组
		
		private var _playerBetButtonGroup:Widget_BetButtonGroup;			// 玩家押注倍数操作按钮
		
		private var _playerGiveButtonGroup:Widget_GiveButtonGroup;		// 玩家提交结果按钮组
		private var _playerGiveCalculater:Widget_GiveCalculater;		// 玩家算牛辅助框
		
		
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
						
			_playerRobDealerState = new ExImage(/*resManager.getResourceDev("table.notify_norob")*/);
			_playerRobDealerState.x = 120;
			_playerRobDealerState.visible = false;			
			addChild(_playerRobDealerState);
			
			_playerRobDealerButtonGroup = new Widget_RobDealerButtonGroup();
			_playerRobDealerButtonGroup.x = 180;
			_playerRobDealerButtonGroup.y = 0;
			_playerRobDealerButtonGroup.visible = false;
			addChild(_playerRobDealerButtonGroup);
			
			_playerDealerState = new ExImage(resManager.getResourceDev("table.dealer"));
			_playerDealerState.x = 0;
			_playerDealerState.y = 60;
			_playerDealerState.visible = false;
			addChild(_playerDealerState);
			
			_playerBetButtonGroup = new Widget_BetButtonGroup();
			_playerBetButtonGroup.x = 180;
			_playerBetButtonGroup.y = 0;
			_playerBetButtonGroup.visible = false;
			addChild(_playerBetButtonGroup);
			
			_playerGiveButtonGroup = new Widget_GiveButtonGroup();
			_playerGiveButtonGroup.visible = false;
			_playerGiveButtonGroup.x = 620;
			_playerGiveButtonGroup.y = 60;
			_playerGiveButtonGroup.addEventListener(Event.TRIGGERED, onTriggered);
			addChild(_playerGiveButtonGroup);
			
			_playerGiveCalculater = new Widget_GiveCalculater();
			_playerGiveCalculater.visible = false;
			addChild(_playerGiveCalculater);			
		}
		
		
		protected function onTouch(event:TouchEvent) : void
		{			
			var touchObj:Touch = event.getTouch(_playerCards);
			if (touchObj)
			{
				if (touchObj.phase == TouchPhase.ENDED)
				{
					if (_playerCards.selectedCount == 3)
					{
						_playerGiveButtonGroup.setGiveNiuEnabled(true);
					}
					else
					{
						_playerGiveButtonGroup.setGiveNiuEnabled(false);
					}
				}
				
				event.stopImmediatePropagation();
			}						
		}
		
		private function onTriggered(event:Event):void
		{	
			SoundManager.instance().playButtonClick();
			
			if (_playerGiveButtonGroup.isGiveNiuButton(event.target as Button))
			{
				NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.USER_GIVE, _playerCards.getUserGivePokers());				
			}
			else
			{
				NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.USER_GIVE, _playerCards.getDefaultPokers());
			}
						
			_playerGiveButtonGroup.visible = false;
			_playerCards.visible = false;
		}
		
		public function get playerHeader() : Widget_PlayerHeader
		{
			return _playerHeader;
		}
		
		public function get playerCards() : Widget_PlayerCards
		{
			return _playerCards;
		}		
		
		public function get playerRobDealerButtonGroup() : Widget_RobDealerButtonGroup
		{
			return _playerRobDealerButtonGroup;
		}
		
		public function get playerRobDealerState() : ExImage
		{
			return _playerRobDealerState;
		}
		
		public function get playerDealerState() : ExImage
		{
			return _playerDealerState;
		}
		
		public function get playerBetButtonGroup() : Widget_BetButtonGroup
		{
			return _playerBetButtonGroup;
		}
		
		public function get playerGiveButtonGroup() : Widget_GiveButtonGroup
		{
			return _playerGiveButtonGroup;
		}
		
		public function get playerGiveCalculater() : Widget_GiveCalculater
		{
			return _playerGiveCalculater;
		}
	}
}