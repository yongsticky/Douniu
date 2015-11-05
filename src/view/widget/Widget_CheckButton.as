package view.widget
{
	import resource.ResManager;
	import resource.font.FontColor;
	import resource.font.FontName;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_CheckButton extends ExSprite
	{
		public static const STATUS:String = "widget.check_button.status";
		
		private var _checker:ExImage;		
		private var _text:TextField;
		
		private var _textStr:String;
		private var _checked:Boolean;
		
		public function Widget_CheckButton(name:String=null, text:String = "", checked:Boolean = false)
		{
			super(name);
			
			_checked = checked;
			_textStr = text;
		}
		
		override protected function createChildren():void
		{						
			_checker = new ExImage(ResManager.instance().getResource(_checked ? "ui.checkbox_selected":"ui.checkbox_unselected"));			
			addChild(_checker);
			_checker.addEventListener(TouchEvent.TOUCH, onTouchChecker);
			
			_text = new TextField(100, 28, _textStr, FontName.YAHEI, 14, FontColor.BEIGE, true);
			_text.hAlign = HAlign.LEFT;			
			_text.x = _checker.x + _checker.width + 2;
			addChild(_text);
		}
		
		private function onTouchChecker(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_checker, TouchPhase.ENDED);
			if (touch)
			{
				checked = !checked;				
			}
		}				
		
		public function get textField() : TextField
		{
			return _text;
		}
		
		public function set checked(value:Boolean) : void
		{
			if (_checked != value)
			{
				_checked = value;
				_checker.res = ResManager.instance().getResource(_checked ? "ui.checkbox_selected":"ui.checkbox_unselected");
				
				dispatchEvent(new Event(STATUS, false, _checked));
			}	
		}
		
		public function get checked() : Boolean
		{
			return _checked;
		}
	}
}