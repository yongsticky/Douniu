package view.scene.table.cell
{	
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import douniu.NiuType;
	
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	import resource.font.FontColor;
	
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
	import view.widget.Widget_ImageTextField;
	
	public class Player extends ExSprite
	{
		private var _playerHeader:PlayerHeader;						// 玩家头像
		private var _playerCards:PlayerCards;							// 玩家手牌		

		private var _playerRobDealerNotify:Widget_ImageTextField;		// 玩家抢庄通知
		private var _playerAsDealer:ExImage;								// 玩家获得庄家状态
		private var _playerRobDealerButtonGroup:RobDealerButtonGroup;			// 玩家抢庄倍数操作按钮组
		
		private var _playerBetButtonGroup:BetButtonGroup;			// 玩家押注倍数操作按钮
		private var _playerBetNotify:Widget_ImageTextField;		// 玩家押注通知
		private var _playerBetMultiple:Widget_ImageTextField;		// 玩家押注的倍数
		
		private var _playerGiveButtonGroup:GiveButtonGroup;		// 玩家提交结果按钮组
		private var _cardCalculater:CardCalculater;				// 玩家算牛辅助框
		
		private var _playerReadyButtonGroup:ReadyButtonGroup;			// 换桌和退出
		
		private var _playerNiuResult:ExImage;				// 牛的结果
		
		private var _flowMoneyChangeText:TextField;	// 输赢浮动数字
		
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
			
			_playerRobDealerNotify = new Widget_ImageTextField();
			_playerRobDealerNotify.x = -10;
			_playerRobDealerNotify.y = 60;
			_playerRobDealerNotify.setTextAnchor(0, 5);
			_playerRobDealerNotify.visible = false;			
			addChild(_playerRobDealerNotify);		
			
				
			_playerRobDealerButtonGroup = new RobDealerButtonGroup();
			_playerRobDealerButtonGroup.x = 140;
			_playerRobDealerButtonGroup.y = 120;
			_playerRobDealerButtonGroup.visible = false;
			addChild(_playerRobDealerButtonGroup);
			
			_playerAsDealer = new ExImage(resManager.getResource("ui.dealer"));
			_playerAsDealer.x = 76;
			_playerAsDealer.y = 130;
			_playerAsDealer.visible = false;
			addChild(_playerAsDealer);
			
			_playerBetButtonGroup = new BetButtonGroup();
			_playerBetButtonGroup.x = 140;
			_playerBetButtonGroup.y = 120;
			_playerBetButtonGroup.visible = false;
			addChild(_playerBetButtonGroup);
			
			
			_playerBetNotify = new Widget_ImageTextField();
			_playerBetNotify.x = 42;
			_playerBetNotify.y = 96;
			_playerBetNotify.setTextAnchor(0, 5);
			_playerBetNotify.setBackground(resManager.getResource("ui.tips_bg_white_r"));
			_playerBetNotify.visible = false;			
			addChild(_playerBetNotify);
			
			// !!必须在addChild后面，因为createChilren实在initialize中触发的（不合理）
			_playerBetNotify.textField.color = FontColor.DARKRED;	
			
			
			_playerBetMultiple = new Widget_ImageTextField();
			_playerBetMultiple.x = 76;
			_playerBetMultiple.y = 130;			
			_playerBetMultiple.setTextAnchor(0, 2);
			_playerBetMultiple.setBackground(resManager.getResource("ui.bet_text_bg"));
			_playerBetMultiple.visible = false;
			addChild(_playerBetMultiple);
			_playerBetMultiple.textField.fontSize = 12;			
			
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
			
			_playerNiuResult = new ExImage();
			_playerNiuResult.x = 260;
			_playerNiuResult.y = 40;
			addChild(_playerNiuResult);
			
			_flowMoneyChangeText = new TextField(320, 60, "", "Arial", 32, 0xcd0000, true);
			_flowMoneyChangeText.hAlign = HAlign.LEFT;
			_flowMoneyChangeText.x = 200;
			_flowMoneyChangeText.y = 20;			
			_flowMoneyChangeText.filter = BlurFilter.createDropShadow();
			_flowMoneyChangeText.visible = false;
			addChild(_flowMoneyChangeText);
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
		}
		
		public function show(nickName:String, coin:int, headerIcon:int) : void
		{
			visible = true;
			
			_playerHeader.visible = true;
			_playerHeader.setPlayerInfo(nickName, coin, headerIcon);
		}
		
		public function showReadyButtonGoroup(showContinue:Boolean = false) : void
		{
			_playerReadyButtonGroup.visible = true;
			_playerReadyButtonGroup.showContinue(showContinue);
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
		
		public function showRobDealerNotify(rob:Boolean) : void
		{	
			_playerRobDealerNotify.visible = true;
			
			if (rob)
			{
				_playerRobDealerNotify.setText("抢庄!");
				_playerRobDealerNotify.setBackground(ResManager.instance().getResource("ui.tips_bg_yellow_l"));
			}
			else
			{
				_playerRobDealerNotify.setText("不抢!");
				_playerRobDealerNotify.setBackground(ResManager.instance().getResource("ui.tips_bg_blue_l"));	
			}
		}
		
		public function hideRobDealerNotify() : void
		{
			_playerRobDealerNotify.visible = false;	
		}
		
		public function setAsDealer(): void
		{
			var tn:Tween = new Tween(_playerAsDealer, 0.4);
			
			var dstX:Number = _playerAsDealer.x;
			var dstY:Number = _playerAsDealer.y;			
			
			var srcPt:Point = new Point();
			globalToLocal(new Point(stage.stageWidth/2, stage.stageHeight/2), srcPt);
			_playerAsDealer.x = srcPt.x;
			_playerAsDealer.y = srcPt.y;
			_playerAsDealer.visible = true;
			
			tn.moveTo(dstX, dstY);
			
			getOwnerLayer().juggler.add(tn);			
		}
		
		public function unsetAsDealer() : void
		{
			_playerAsDealer.visible = false;
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
		
		public function showBetNotify(x:int) : void
		{
			_playerBetNotify.visible = true;
			
			_playerBetNotify.setText("压"+x.toString()+"倍!");			
		}
		
		public function hideBetNotify() : void
		{
			_playerBetNotify.visible = false;
		}
		
		public function showCards(tiles:ByteArray) : void
		{
			_playerCards.show(tiles);
		}
		
		public function showBetMultiple(x:int) : void
		{
			_playerBetMultiple.visible = true;
			_playerBetMultiple.setText(x.toString() + "倍");
		}
		
		public function hideBetMultiple() : void
		{
			_playerBetMultiple.visible = false;			
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
		
		public function showNiuResult(type:int) : void
		{				
			_playerNiuResult.res = ResManager.instance().getResource("ui.niu_"+type);
			_playerNiuResult.visible = true;
		}	
		
		public function hideNiuResult() : void
		{
			_playerNiuResult.visible = false;	
		}
	
		public function flowMoneyChangeText(change:int) : void
		{
			if (change < 0)
			{
				_flowMoneyChangeText.color = 0xCD0000;
				_flowMoneyChangeText.text = change.toString();
			}
			else
			{
				_flowMoneyChangeText.color = 0xE96F0F;
				_flowMoneyChangeText.text = "+" + change.toString();
			}			
			
			_flowMoneyChangeText.y += 32;
			_flowMoneyChangeText.alpha = 255;
			_flowMoneyChangeText.visible = true;
			
			
			var tn:Tween = new Tween(_flowMoneyChangeText, 2, Transitions.EASE_IN);
			tn.moveTo(_flowMoneyChangeText.x, _flowMoneyChangeText.y-32);
			tn.fadeTo(0);
			tn.onComplete = onFlowAnimationComplete;
			
			getOwnerLayer().juggler.add(tn);
			
		}
		
		private function onFlowAnimationComplete() : void
		{
			_flowMoneyChangeText.visible = false;
		}
	
		public function updateMoney(current:int) : void
		{
			_playerHeader.setPlayerInfo(null, current, null);
		}		
	}
	
	
}