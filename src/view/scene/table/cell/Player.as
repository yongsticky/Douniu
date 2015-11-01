package view.scene.table.cell
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
	
	public class Player extends ExSprite
	{
		private var _playerHeader:PlayerHeader;						// 玩家头像
		private var _playerCards:PlayerCards;							// 玩家手牌
		
		private var _playerReadyButtonGroup:ReadyButtonGroup;			// 换桌和退出

		private var _playerRobDealerState:ExImage;								// 玩家抢庄状态
		private var _playerDealerState:ExImage;							// 玩家获得庄家状态
		private var _playerRobDealerButtonGroup:RobDealerButtonGroup;			// 玩家抢庄倍数操作按钮组
		
		private var _playerBetButtonGroup:BetButtonGroup;			// 玩家押注倍数操作按钮
		
		private var _playerGiveButtonGroup:GiveButtonGroup;		// 玩家提交结果按钮组
		private var _cardCalculater:CardCalculater;		// 玩家算牛辅助框
		
		
		public function Player(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_playerHeader = new PlayerHeader();			
			_playerHeader.y = 100;
			_playerHeader.visible = false;
			addChild(_playerHeader);
			
			_playerCards = new PlayerCards();
			_playerCards.x = 140;
			_playerCards.y = 100;
			_playerCards.visible = false;
			_playerCards.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(_playerCards);
			
			_playerReadyButtonGroup = new ReadyButtonGroup();
			_playerReadyButtonGroup.visible = false;
			_playerReadyButtonGroup. x = 140;
			_playerReadyButtonGroup.y = 120;
			addChild(_playerReadyButtonGroup);
						
			/*
			_playerRobDealerState = new ExImage();
			_playerRobDealerState.x = 76;
			_playerRobDealerState.y = 130;
			_playerRobDealerState.visible = false;			
			addChild(_playerRobDealerState);			
			*/
			
			
			_playerRobDealerButtonGroup = new RobDealerButtonGroup();
			_playerRobDealerButtonGroup.x = 140;
			_playerRobDealerButtonGroup.y = 120;
			_playerRobDealerButtonGroup.visible = false;
			addChild(_playerRobDealerButtonGroup);
			
			_playerDealerState = new ExImage(resManager.getResource("ui.dealer"));
			_playerDealerState.x = 76;
			_playerDealerState.y = 130;
			_playerDealerState.visible = false;
			addChild(_playerDealerState);
			
			_playerBetButtonGroup = new BetButtonGroup();
			_playerBetButtonGroup.x = 140;
			_playerBetButtonGroup.y = 120;
			_playerBetButtonGroup.visible = false;
			addChild(_playerBetButtonGroup);
			
			_playerGiveButtonGroup = new GiveButtonGroup();
			_playerGiveButtonGroup.visible = false;
			_playerGiveButtonGroup.x = 520;
			_playerGiveButtonGroup.y = 90;
			_playerGiveButtonGroup.addEventListener(Event.TRIGGERED, onTriggered);
			addChild(_playerGiveButtonGroup);
			
			_cardCalculater = new CardCalculater();
			_cardCalculater.x = 180;			
			_cardCalculater.visible = false;
			addChild(_cardCalculater);
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
					
					var v:Vector.<int> = new <int>[0,0,0,0,0];
					var selVec:Vector.<int> = _playerCards.getCurrentSelectedPokers();
					for (var i:int = 0; i < selVec.length; ++i)
					{
						v[i] = selVec[i];
					}
					
					_cardCalculater.update(v);
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
				NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.USER_GIVE, _playerCards.getAutoPokers());
			}
						
			_playerGiveButtonGroup.visible = false;
			_playerCards.visible = false;
		}
		
		public function get playerHeader() : PlayerHeader
		{
			return _playerHeader;
		}
		
		public function get playerCards() : PlayerCards
		{
			return _playerCards;
		}	
		
		public function get playerReadyButtonGroup() : ReadyButtonGroup
		{
			return _playerReadyButtonGroup;
		}
		
		public function get playerRobDealerButtonGroup() : RobDealerButtonGroup
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
		
		public function get playerBetButtonGroup() : BetButtonGroup
		{
			return _playerBetButtonGroup;
		}
		
		public function get playerGiveButtonGroup() : GiveButtonGroup
		{
			return _playerGiveButtonGroup;
		}
		
		public function get cardCalculater() : CardCalculater
		{
			return _cardCalculater;
		}
	}
}