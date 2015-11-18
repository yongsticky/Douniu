package view.widget
{		
	import resource.ResManager;
	import resource.font.FontColor;
	import resource.font.FontName;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_MessgeBox extends ExSprite
	{
		private var _bg:ExImage;
		private var _close:Button;
		private var _text:TextField;
		private var _button:Button;
		
		private var _infoText:String;
		private var _buttonText:String;
		
		public static const CLICK:String = "messagebox.button.click";
		
		public function Widget_MessgeBox(name:String=null, infoText:String = "", buttonText:String = "")
		{
			super(name);
			
			_infoText = infoText;
			_buttonText = buttonText;
		}
		
		override protected function createChildren():void
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResource("ui.dialog_bg"));
			addChild(_bg);
			
			_close = new Button(resManager.getResource("ui.round_button_close"), "");
			_close.x = width - _close.width - 2;			
			_close.addEventListener(Event.TRIGGERED, onClose);
			addChild(_close);
			
			
			_text = new TextField(284, 92, _infoText, FontName.YAHEI, 16, FontColor.DARKRED, true);			
			_text.x = 16;
			_text.y = 36;			
			addChild(_text);
			
			_button = new Button(resManager.getResource("ui.round_button_bg_yellow"), _buttonText);
			_button.fontBold = true;
			_button.fontColor = FontColor.DARKRED;
			_button.fontName = FontName.YAHEI;
			_button.fontSize = 16;
			_button.x = (width - _button.width) / 2;
			_button.y = height - _button.height - 20;
			_button.addEventListener(Event.TRIGGERED, onButtonClicked);
			addChild(_button);
		}
		
		public function set infoText(value:String) : void
		{
			_text.text = value;
		}
		
		public function set buttonText(value:String) : void
		{
			_button.text = value;
		}
		
		public function hide() : void
		{
			if (stage)
			{				
				stage.removeChild(this);
			}
		}
		
		private function onClose(event:Event):void
		{			
			hide();
			
			event.stopImmediatePropagation();
		}
		
		private function onButtonClicked(event:Event):void
		{
			dispatchEvent(new Event(CLICK));
			
			event.stopImmediatePropagation();
		}
	}
}