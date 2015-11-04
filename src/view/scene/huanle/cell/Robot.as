package view.scene.huanle.cell
{
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExSprite;
	
	public class Robot extends ExSprite
	{
		protected var _pokers:Vector.<PokerImage>;
		protected var _betButton:Button;
		
		protected var _sepWidth:int = 20;
		
		protected var _seatId:int;
		
		private static const MAX_POKER_NUM:int = 5;
		
		public function Robot(seatId:int, name:String=null)
		{	
			_seatId = seatId;
			
			super(name);		
		}
		
		override protected function createChildren():void
		{
			_pokers = new Vector.<PokerImage>(MAX_POKER_NUM);			
			
			var startX:int = 0;
			for (var i:int = 0; i < MAX_POKER_NUM; ++i)
			{
				var pI:PokerImage = new PokerImage();
				pI.card = 0;
				
				pI.x = startX;	
				addChild(pI);
				
				_pokers[i] = pI;
				
				
				startX += _sepWidth;
			}
			
			_betButton = new Button(ResManager.instance().getResource("ui.button_bg_orange"), "押注");
			_betButton.x = (width - _betButton.width)>>1;
			_betButton.y = 120;			
			addChild(_betButton);
		}
		
		private function onTriggered(event:Event):void
		{				
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.HUANLE_BET);
		}
		
		public function get seatId() : int
		{
			return _seatId;
		}
				
		public function set sepWidth(value:int) : void
		{
			_sepWidth = value;
		}
		
		public function get betButton() : Button
		{
			return _betButton;
		}
		
		public function setPokers(v:vector.<int>) : void
		{
			for (var i:int = 0; i < MAX_POKER_NUM; ++i)
			{
				_pokers[i].card = v[i];
			}
		}
	}
}


import douniu.NiuCard;

import resource.ResManager;

import view.framework.ExImage;

class PokerImage extends ExImage
{	
	private var _card:int;
	
	private var COLOR_TO_STR:Array = ["hei", "hong", "mei", "fang"];
	
	public function PokerImage()
	{	
		super();
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