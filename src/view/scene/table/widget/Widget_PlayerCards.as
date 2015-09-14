package view.scene.table.widget
{
	import douniu.NiuCard;
	
	import resource.ResManager;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_PlayerCards extends ExSprite
	{		
		private static const MAX_CARDS_NUM:int = 5;
		
		private var _pokers:Vector.<Poker>;
				
		
		public function Widget_PlayerCards(name:String = null)
		{
			super(name);	
			
			_pokers = new Vector.<Poker>(MAX_CARDS_NUM);
		}
		
		override protected function createChildren() : void
		{
			
		}
				
		public function setPokers(cards:Vector.<NiuCard>) : void
		{	
			removeChildren(0, -1, true);
			
			var maxCount:int = cards.length<MAX_CARDS_NUM ? cards.length:MAX_CARDS_NUM;			
			var startX:int = 0;
			for (var i:int = 0; i < maxCount; i++)
			{
				var p:Poker = new Poker(cards[i]); 
				
				p.x = startX;
				p.addEventListener(TouchEvent.TOUCH, onTouch);
				
				addChild(p);
				
				startX += 73;
				
				_pokers[i] = p;
			}			
		}		
		
		public function getSelectedPokerIndex() : Vector.<int>
		{
			var selectedVec:Vector.<int> = new Vector.<int>();
			
			for (var i:int = 0; i < MAX_CARDS_NUM; ++i)
			{
				var p:Poker = _pokers[i];
				if (p && p.selected)
				{
					selectedVec.push(i);
				}
			}
			
			return selectedVec;
		}
		
		
		protected function onTouch(event:TouchEvent):void
		{
			var theImage:Poker =  event.target as Poker;
			
			var touchObj:Touch = event.getTouch(theImage);
			
			if (touchObj)
			{
				if (touchObj.phase == TouchPhase.ENDED)
				{	
					if (theImage.selected)
					{
						theImage.y = 0;	
						theImage.selected = false;
					}
					else
					{
						theImage.y = -15;
						theImage.selected = true;
					}					
				}			
			}
		}
	}
}


import douniu.NiuCard;

import resource.ResManager;

import view.framework.ExImage;


class Poker extends ExImage
{
	private var _selected:Boolean = false;
	private var _card:NiuCard;
	
	private var COLOR_TO_STR:Array = ["hei", "hong", "mei", "fang"];
	
	public function Poker(card:NiuCard)
	{	
		super(getPokerResource(card));
	}
	
	public function set selected(selected:Boolean) : void
	{
		_selected = selected;
	}
	
	public function get selected() : Boolean
	{
		return _selected;
	}
		
	public function get card() : NiuCard
	{
		return _card;
	}
	
	private function getPokerResource(card:NiuCard) : *
	{
		var res:*;
		if (card)
		{
			res = ResManager.instance().getResourceDev("poker." + COLOR_TO_STR[card.color] + "." + card.number.toString());
		}
		else
		{
			res = ResManager.instance().getResourceDev("poker.bei");
		}
		
		return res;
	}
}