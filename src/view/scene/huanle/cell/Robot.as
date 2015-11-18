package view.scene.huanle.cell
{
	import flash.utils.ByteArray;
	
	import resource.ResManager;
	import resource.font.FontColor;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.text.TextField;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;

	public class Robot extends ExSprite
	{
		private var _pokers:Vector.<PokerImage>;
		private var _betButton:Button;
		private var _niuResult:ExImage;
		private var _result:TextField;
		
		private var _sepWidth:int = 20;
		private var _seatId:int;
		
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
			
			
			_niuResult = new ExImage();
			_niuResult.x = (_sepWidth*4 + 61 - 66) / 2;
			_niuResult.y = -40;
			_niuResult.visible = false;
			addChild(_niuResult);
			
			_result = new TextField(140, 40, "");
			_result.fontSize = 12;
			_result.bold = true;
			_result.x = 0;
			_result.y = 30;
			_result.visible = false;
			
			
			_result.addChild(new Quad(140, 40, 0x222222));
			
			addChild(_result);
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
		
		public function setPokers(v:ByteArray) : void
		{
			if (v)
			{
				for (var i:int = 0; i < MAX_POKER_NUM; ++i)
				{
					_pokers[i].card = int(v[i]);
				}
			}
			else
			{
				for (var j:int = 0; j < MAX_POKER_NUM; ++j)
				{
					_pokers[j].card = 0;
				}	
			}
		}
		
		public function showNiuResult(type:int) : void
		{				
			_niuResult.res = ResManager.instance().getResource("ui.niu_"+type);
			_niuResult.visible = true;
		}	
		
		public function hideNiuResult() : void
		{
			_niuResult.visible = false;	
		}
		
		public function showResult(winOrLose:int, item:int) : void
		{
			_result.visible = true;
			
			_result.color = FontColor.BEIGE;
			_result.text = "<" + winOrLose.toString() + "> - <" + item.toString() + ">";			
		}
		
		public function hideResult() : void
		{
			_result.visible = false;
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