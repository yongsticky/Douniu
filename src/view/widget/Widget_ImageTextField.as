package view.widget
{
	import resource.font.FontColor;
	import resource.font.FontName;
	
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_ImageTextField extends ExSprite
	{
		private var _bg:ExImage;
		private var _text:TextField;
		
		private var _bgRes:*;
		private var _textStr:String;
		private var _anchorX:int;
		private var _anchorY:int;
		
		private var _created:Boolean = false;
		
		public function Widget_ImageTextField(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			_bg = new ExImage(_bgRes);
			addChild(_bg);
			
			_text = new TextField(1, 1, _textStr, FontName.YAHEI, 16, FontColor.WHITE, true);
			_text.vAlign = VAlign.TOP;
			addChild(_text);
			
			_created = true;
			
			apply();
		}
		
		public function setBackground(res:*) : void
		{	
			if (res)
			{
				_bgRes = res;
				
				if (_created)
				{					
					_bg.res = _bgRes;					
					apply();
				}							 
			}			
		}
				
		public  function setText(text:String):void
		{
			_textStr = text;
			
			if (_created)
			{
				_text.text = _textStr;	
			}						
		}
		
		public function setTextAnchor(x:int, y:int) : void
		{
			_anchorX = x;
			_anchorY = y;
			
			if (_created)
			{
				apply();	
			}
		}	
	
		
		public function get textField() : TextField
		{
			return _text;
		}
		
		private function apply() : void
		{
			_text.x = _anchorX;
			_text.width = _bg.width - _anchorX;
			_text.y = _anchorY;
			_text.height = _bg.height - _anchorY;
		}
	}
}