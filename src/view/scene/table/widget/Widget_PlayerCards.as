package view.scene.table.widget
{
	import camu.errors.IndexOutOfRangeError;
	import camu.errors.NullObjectError;
	import camu.errors.UnexpectedLengthError;
	
	import douniu.NiuCard;
	
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.animation.Tween;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_PlayerCards extends ExSprite
	{		
		private static const MAX_POKER_NUM:int = 5;
		
		private var _pokers:Vector.<PokerImage>;
		private var _giveCards:Vector.<int>;
		private var _selectedCount:int;
				
		
		public function Widget_PlayerCards(name:String = null)
		{
			super(name);
			
			_selectedCount = 0;
			
			_giveCards = new <int>[0, 0, 0, 0, 0];			
		}
		
		override protected function createChildren() : void
		{
			_pokers = new Vector.<PokerImage>(MAX_POKER_NUM);
			
			var startX:int = 0;
			for (var i:int = 0; i < MAX_POKER_NUM; ++i)
			{
				var pI:PokerImage = new PokerImage();				
				
				pI.x = startX;
				pI.addEventListener(TouchEvent.TOUCH, onTouch);
				pI.visible = false;
				addChild(pI);
				
				_pokers[i] = pI;
				
				startX += 73;
			}		
		}
				
		public function setPokers(cards:Vector.<int>) : void
		{				
			if (!cards)
			{
				throw new NullObjectError();
			}
			
			if (cards.length != MAX_POKER_NUM)
			{
				throw new UnexpectedLengthError();
			}
			
			var maxIndex:int = cards.length;
			for (var i:int = 0; i < maxIndex; ++i)
			{
				var pI:PokerImage = _pokers[i];
				pI.card = cards[i];	
				pI.selected = false;
				pI.y = 0;
				
				_giveCards[i] = cards[i];				
			}
			
			_selectedCount = 0;
		}
		
		public function updatePoker(index:int, card:int) : void
		{
			if (index < 0 || index >= MAX_POKER_NUM)
			{
				throw new IndexOutOfRangeError();
			}
						
			var pI:PokerImage = _pokers[index];
			pI.card = card;
			pI.selected = false;
			pI.y = 0;
				
			_giveCards[index] = card;
		}
		
		private var _aniCurIndex:int = 0;
		public function doGiveAnimation() : void
		{			
			var pI:PokerImage = _pokers[_aniCurIndex];
			pI.visible = true;
			
			var dstX:Number = pI.x;
			var dstY:Number = pI.y;
						
			pI.x = 80;
			pI.y = -250;
			
			var tween:Tween = new Tween(pI, 0.1);
			tween.moveTo(dstX, dstY);
			tween.onComplete =  onGiveAnimationComplete;
			
			getOwnerLayer().juggler.add(tween);
		}
		
		private function onGiveAnimationComplete() : void
		{
				++ _aniCurIndex;
				
				if (_aniCurIndex < MAX_POKER_NUM)
				{
					doGiveAnimation();
				}
				else
				{
					_aniCurIndex = 0;
				}
		}
		
		public function hideAllPokers() : void
		{
			for (var i:int = 0; i < MAX_POKER_NUM; ++i)
			{
				_pokers[i].visible = false;
			}
		}
		
		public function get selectedCount() : int
		{
			return _selectedCount;
		}
		
		public function getDefaultPokers() : Vector.<int>
		{
			return _giveCards;
		}
		
		public function getUserGivePokers() : Vector.<int>
		{			
			if (_selectedCount == 3)
			{
				var curSelectedIndex:int = 0;
				var curUnselectedIndex:int = 3;
				for (var i:int = 0; i < MAX_POKER_NUM; ++i)
				{
					var pI:PokerImage = _pokers[i];				
					if (pI.selected)
					{
						_giveCards[curSelectedIndex] = pI.card;
						++ curSelectedIndex;
					}
					else
					{
						_giveCards[curUnselectedIndex] = pI.card;
						++ curUnselectedIndex;
					}
				}
			}
			
			return _giveCards;
		}				
		
		protected function onTouch(event:TouchEvent):void
		{
			var pI:PokerImage =  event.currentTarget as PokerImage;			
			if (pI && pI.card > 0)
			{
				var touchObj:Touch = event.getTouch(pI);
				
				if (touchObj)
				{					
					if (touchObj.phase == TouchPhase.ENDED)
					{	
						if (pI.selected)
						{
							pI.y = 0;	
							pI.selected = false;
							-- _selectedCount;
							
							SoundManager.instance().playSelectCard();
						}
						else
						{
							if (_selectedCount < 3)
							{
								pI.y = -15;
								pI.selected = true;
								++ _selectedCount;
								
								SoundManager.instance().playSelectCard();
							}							
						}				
					}			
				}
			}
		}
	}
}


import douniu.NiuCard;

import resource.ResManager;

import view.framework.ExImage;


class PokerImage extends ExImage
{
	private var _selected:Boolean = false;
	private var _card:int;
	
	private var COLOR_TO_STR:Array = ["hei", "hong", "mei", "fang"];
	
	public function PokerImage()
	{	
		super();
	}
	
	public function set selected(selected:Boolean) : void
	{
		_selected = selected;
	}
	
	public function get selected() : Boolean
	{
		return _selected;
	}
		
	public function get card() : int
	{
		return _card;
	}
	
	public function set card(c:int) : void
	{
		_card = c;
		super.res = getPokerResource(_card);
	}
	
	private function getPokerResource(c:int) : *
	{
		var res:*;
		if (c > 0)
		{
			res = ResManager.instance().getResource("poker." + COLOR_TO_STR[NiuCard.getColor(c)] + "_" + NiuCard.getNumber(c).toString() + ".png");
		}
		else
		{
			res = ResManager.instance().getResource("poker.bei.png");
		}
		
		return res;
	}
}