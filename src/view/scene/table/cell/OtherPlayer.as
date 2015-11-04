package view.scene.table.cell
{
	import flash.geom.Point;
	
	import resource.ResManager;
	import resource.font.FontColor;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	import view.widget.Widget_ImageTextField;
	
	public class OtherPlayer extends ExSprite
	{
		private var _seat:int;											// 座位号 从玩家开始 左手边为0 顺时针至4
		
		private var _playerHeader:PlayerHeader;						// 头像信息
		private var _playerCards:OtherPlayerCards;						// 手牌
		private var _playerRobDealerNotify:Widget_ImageTextField;		// 抢庄状态
		private var _playerRobDealerMultiple:ExImage;					// 抢庄倍数
		private var _playerAsDealer:ExImage;							// 庄家状态
		private var _playerBetNotify:Widget_ImageTextField;			// 押注通知
		
		private var _flowMoneyChangeText:TextField;
		
		
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
			_playerCards.visible = false;
			addChild(_playerCards);
			
			_playerRobDealerNotify = new Widget_ImageTextField();
			_playerRobDealerNotify.x = _seat < 3 ? -10:5;
			_playerRobDealerNotify.y = - 40;
			_playerRobDealerNotify.setTextAnchor(0, 5);
			_playerRobDealerNotify.visible = false;			
			addChild(_playerRobDealerNotify);			
			
			_playerAsDealer = new ExImage(ResManager.instance().getResource("ui.dealer"));
			_playerAsDealer.x = 20;
			_playerAsDealer.y = -50;
			_playerAsDealer.visible = false;
			addChild(_playerAsDealer);			
			
			_playerBetNotify = new Widget_ImageTextField();
			_playerBetNotify.x = _seat < 3 ? 42:-58;
			_playerBetNotify.y = -2;
			_playerBetNotify.setTextAnchor(0, 5);
			_playerBetNotify.setBackground(ResManager.instance().getResource(_seat < 3 ? "ui.tips_bg_white_r":"ui.tips_bg_white_l"));
			_playerBetNotify.visible = false;			
			addChild(_playerBetNotify);
			
			// !!必须在addChild后面，因为createChilren实在initialize中触发的（不合理）
			_playerBetNotify.textField.color = FontColor.DARKRED;
			
			
			_flowMoneyChangeText = new TextField(320, 60, "", "Arial", 28, 0xcd0000, true);
			_flowMoneyChangeText.hAlign = HAlign.LEFT;
			_flowMoneyChangeText.filter = BlurFilter.createDropShadow();			
			_flowMoneyChangeText.visible = false;
			addChild(_flowMoneyChangeText);	
			
			if (_seat > 2)
			{
				_playerCards.x = -160;				
				_flowMoneyChangeText.x = - 140;
				
			}
			else
			{
				_playerCards.x = 100;
				
				_flowMoneyChangeText.x = 120;				
			}			
		}	
				
		public function show(nickName:String, money:int, headerIcon:int) : void
		{
			visible = true;
			
			_playerHeader.setPlayerInfo(nickName, money, headerIcon);
		}
		
		public function hide() : void
		{
			visible = false;
		}
		
		public function showRobDealerNotify(rob:Boolean) : void
		{		
			_playerRobDealerNotify.visible = true;
			
			if (rob)
			{
				_playerRobDealerNotify.setText("抢庄!");
				_playerRobDealerNotify.setBackground(ResManager.instance().getResource(_seat < 3 ? "ui.tips_bg_yellow_l":"ui.tips_bg_yellow_r"));
			}
			else
			{
				_playerRobDealerNotify.setText("不抢!");
				_playerRobDealerNotify.setBackground(ResManager.instance().getResource(_seat < 3 ? "ui.tips_bg_blue_l":"ui.tips_bg_blue_r"));	
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
		
		public function showBetNotify(x:int) : void
		{
			_playerBetNotify.visible = true;
			
			_playerBetNotify.setText("压"+x.toString()+"倍!");			
		}
		
		public function hideBetNotify() : void
		{
			_playerBetNotify.visible = false;
		}
		
		
		public function showCards(cards:Vector.<int>) : void
		{
			_playerCards.visible = true;
			if (cards)
			{
				_playerCards.setPokers(cards);
			}
			else
			{
				_playerCards.setPokersNull();
			}
		}
		
		public function hideCards() : void
		{
			_playerCards.visible = false;
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