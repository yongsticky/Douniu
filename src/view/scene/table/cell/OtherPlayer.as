package view.scene.table.cell
{
	import flash.geom.Point;
	
	import resource.ResManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
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
		
		private var _moneyChange:TextField;
		
		
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
								
			}
			else
			{
								
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
			
			_moneyChange = new TextField(320, 60, "", "Arial", 28, 0xcd0000, true);
			_moneyChange.hAlign = HAlign.LEFT;
			_moneyChange.filter = BlurFilter.createDropShadow();			
			_moneyChange.visible = false;
			addChild(_moneyChange);	
			
			if (_seat > 2)
			{
				_playerCards.x = -160;				
				_moneyChange.x = - 140;
				
			}
			else
			{
				_playerCards.x = 100;
				
				_moneyChange.x = 120;				
			}			
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
		
		public function setMoneyChange(change:int) : void
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
			tn.onComplete = onMoneyChangeAnimationComplete;
			
			getOwnerLayer().juggler.add(tn);
			
		}
		
		private function onMoneyChangeAnimationComplete() : void
		{
			_moneyChange.visible = false;
		}
	}
}