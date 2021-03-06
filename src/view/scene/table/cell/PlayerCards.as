package view.scene.table.cell
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import starling.animation.Tween;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
		
	import camu.errors.IndexOutOfRangeError;
	import camu.errors.NullObjectError;
	import camu.errors.UnexpectedLengthError;	
	import sound.SoundManager;
	import douniu.NiuCard;
	import douniu.NiuSuggest;	
	import resource.ResManager;	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class PlayerCards extends ExSprite
	{		
		private static const MAX_POKER_NUM:int = 5;
		
		private var _pokers:Vector.<PokerImage>;
		private var _giveCards:ByteArray;
		private var _currentSelectedCards:Vector.<int>;
		private var _selectedCount:int;
				
		
		public function PlayerCards(name:String = null)
		{
			super(name);
			
			_selectedCount = 0;
			
			_giveCards = new ByteArray();
			_giveCards.length = 5;
			_currentSelectedCards = new Vector.<int>();
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
				
				startX += 61;
			}		
		}
				
		public function setPokers(tiles:ByteArray) : void
		{				
			if (!tiles)
			{
				throw new NullObjectError();
			}
			
			if (tiles.length != MAX_POKER_NUM && tiles.length != MAX_POKER_NUM-1)
			{
				throw new UnexpectedLengthError();
			}
			
			var maxIndex:int = tiles.length;
			for (var i:int = 0; i < maxIndex; ++i)
			{
				var pI:PokerImage = _pokers[i];
				pI.card = int(tiles[i]);	
				pI.selected = false;
				pI.y = 0;
				
				_giveCards[i] = tiles[i];				
			}
			
			if (maxIndex != MAX_POKER_NUM)
			{
				_pokers[maxIndex-1].card = 0;
				_pokers[maxIndex-1].selected = false;
				_pokers[maxIndex-1].y = 0;
				
				_giveCards[maxIndex-1] = 0;
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
		public function show(tiles:ByteArray) : void
		{	
			visible = true;		
			
			if (tiles)
			{
				setPokers(tiles);
				animateShowIt(_pokers[_aniCurIndex]);
			}			
		}
		
		private function animateShowIt(pi:PokerImage) : void
		{			
			pi.visible = true;
			
			var dstX:Number = pi.x;
			var dstY:Number = pi.y;
			
			var srcPt:Point = new Point();
			globalToLocal(new Point(stage.stageWidth/2, stage.stageHeight/2), srcPt);			
			pi.x = srcPt.x;
			pi.y = srcPt.y;
			
			var tween:Tween = new Tween(pi, 0.1);
			tween.moveTo(dstX, dstY);
			tween.onComplete =  onGiveAnimationComplete;
			
			getOwnerLayer().juggler.add(tween);
		}
		
		private function onGiveAnimationComplete() : void
		{
			++ _aniCurIndex;
			
			if (_aniCurIndex < MAX_POKER_NUM)
			{
				animateShowIt(_pokers[_aniCurIndex]);
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
		
		public function getAutoPokers() : ByteArray
		{
			var o:Object = NiuSuggest.getSuggestObject(_giveCards);
			
			var i:int = 0;
			for each(var index:int in o.cardSequence)
			{
				_giveCards[i] = _pokers[index].card;
				++i;
			}		
									
			return _giveCards;
		}
				
		
		public function getUserGivePokers() : ByteArray
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
		
		public function getCurrentSelectedPokers() : Vector.<int>
		{
			_currentSelectedCards.length = 0;			
			
			for (var i:int = 0; i < MAX_POKER_NUM; ++i)
			{
				var pI:PokerImage = _pokers[i];				
				if (pI.selected)
				{
					_currentSelectedCards.push(pI.card);					
				}				
			}
			
			return _currentSelectedCards;
			
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
			res = ResManager.instance().getResource("poker." + COLOR_TO_STR[NiuCard.getColor(c)] + "_" + NiuCard.getNumber(c).toString());
		}
		else
		{
			res = ResManager.instance().getResource("poker.bei");
		}
		
		return res;
	}
}