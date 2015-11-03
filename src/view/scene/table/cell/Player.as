package view.scene.table.cell
{	
	import flash.geom.Point;
	
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExSprite;
	import view.scene.table.layer.Layer_TableMain;
	
	public class Player extends ExSprite
	{
		private var _playerHeader:PlayerHeader;						// 玩家头像
		private var _playerCards:PlayerCards;							// 玩家手牌		

		private var _playerRobDealerState:ExImage;								// 玩家抢庄状态
		private var _playerDealerState:ExImage;							// 玩家获得庄家状态
		private var _playerRobDealerButtonGroup:RobDealerButtonGroup;			// 玩家抢庄倍数操作按钮组
		
		private var _playerBetButtonGroup:BetButtonGroup;			// 玩家押注倍数操作按钮
		
		private var _playerGiveButtonGroup:GiveButtonGroup;		// 玩家提交结果按钮组
		private var _cardCalculater:CardCalculater;		// 玩家算牛辅助框
		
		private var _playerReadyButtonGroup:ReadyButtonGroup;			// 换桌和退出
		
		private var _moneyChange:TextField;
		
		public function Player(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_playerHeader = new PlayerHeader(null, false);			
			_playerHeader.y = 100;
			
			_playerHeader.visible = false;
			addChild(_playerHeader);
			
			_playerCards = new PlayerCards();
			_playerCards.x = 140;
			_playerCards.y = 100;
			_playerCards.visible = false;
			_playerCards.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(_playerCards);
			
			
						
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
			
			_playerReadyButtonGroup = new ReadyButtonGroup();
			_playerReadyButtonGroup.visible = false;
			_playerReadyButtonGroup. x = 160;
			_playerReadyButtonGroup.y = 120;
			addChild(_playerReadyButtonGroup);
			
			_moneyChange = new TextField(320, 60, "", "Arial", 32, 0xcd0000, true);
			_moneyChange.hAlign = HAlign.LEFT;
			_moneyChange.x = 200;
			_moneyChange.y = 20;			
			_moneyChange.filter = BlurFilter.createDropShadow();
			_moneyChange.visible = false;
			addChild(_moneyChange);
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
			
			(getOwnerLayer() as Layer_TableMain).showWaitOtherGiveTimer();
			//_playerCards.visible = false;
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
		
		public function show(nickName:String, coin:int, headerIcon:int) : void
		{
			visible = true;
			
			_playerHeader.visible = true;
			_playerHeader.setPlayerInfo(nickName, coin, headerIcon);
		}
		
		public function showReadyButtonGoroup() : void
		{
			_playerReadyButtonGroup.visible = true;
		}
		
		public function hideReadyButtonGroup() : void
		{
			_playerReadyButtonGroup.visible = false;
		}
		
		public function showRobDealerButtonGroup(x1:int, x2:int, x3:int) : void
		{
			_playerRobDealerButtonGroup.visible = true;
			_playerRobDealerButtonGroup.updateMultiple(x1, x2, x3);			
		}
		
		public function hideRobDealerButtonGroup() : void
		{
			_playerRobDealerButtonGroup.visible = false;
		}
		
		public function setAsDealer(): void
		{
			var tn:Tween = new Tween(_playerDealerState, 0.4);
			
			var dstX:Number = _playerDealerState.x;
			var dstY:Number = _playerDealerState.y;			
			
			var srcPt:Point = new Point();
			globalToLocal(new Point(stage.stageWidth/2, stage.stageHeight/2), srcPt);
			_playerDealerState.x = srcPt.x;
			_playerDealerState.y = srcPt.y;
			_playerDealerState.visible = true;
			
			tn.moveTo(dstX, dstY);
			
			getOwnerLayer().juggler.add(tn);			
		}
		
		public function unsetAsDealer() : void
		{
			_playerDealerState.visible = false;
		}
		
		public function showBetButtonGroup(x1:int, x2:int, x3:int) : void
		{
			_playerBetButtonGroup.visible = true;
			_playerBetButtonGroup.setBetMultiple(x1, x2, x3);
		}
		
		public function hideBetButtonGroup() : void
		{
			_playerBetButtonGroup.visible = false;
		}
		
		public function showCards(cards:Vector.<int>) : void
		{
			_playerCards.show(cards);
		}
		
		public function setCard(index:int, card:int) : void
		{
			_playerCards.updatePoker(index, card);
		}
		
		public function hideCards() : void
		{
			_playerCards.visible = false;
			_playerCards.hideAllPokers();
		}
		
		public function showGiveButtonGroup() : void
		{
			_playerGiveButtonGroup.visible = true;
			
			_playerGiveButtonGroup.setGiveNiuEnabled(false);
		}
		
		public function hideGiveButtonGroup() : void
		{
			_playerGiveButtonGroup.visible = false;
		}
		
		public function showAssistCalculater() : void
		{
			_cardCalculater.visible = true;
		}
		
		public function hideAssistCalculater() : void
		{
			_cardCalculater.reset();
			_cardCalculater.visible = false;
		}
	
		public function flowMoneyChangeText(change:int) : void
		{
			if (change < 0)
			{
				_moneyChange.color = 0xCD0000;
				_moneyChange.text = change.toString();
			}
			else
			{
				_moneyChange.color = 0xE96F0F;
				_moneyChange.text = "+" + change.toString();
			}			
			
			_moneyChange.y += 32;
			_moneyChange.alpha = 255;
			_moneyChange.visible = true;
			
			
			var tn:Tween = new Tween(_moneyChange, 2, Transitions.EASE_IN);
			tn.moveTo(_moneyChange.x, _moneyChange.y-32);
			tn.fadeTo(0);
			tn.onComplete = onFlowAnimationComplete;
			
			getOwnerLayer().juggler.add(tn);
			
		}
		
		private function onFlowAnimationComplete() : void
		{
			_moneyChange.visible = false;
		}
	
		public function updateMoney(current:int) : void
		{
			_playerHeader.setPlayerInfo(null, current, null);
		}		
	}
	
	
}