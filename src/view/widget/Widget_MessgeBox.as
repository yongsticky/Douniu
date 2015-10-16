package view.widget
{	
	import starling.display.Button;
	import starling.display.Stage;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_MessgeBox extends ExSprite
	{
		private var _bg:ExImage;
		private var _text:TextField;
		private var _button:Button;
		
		public function Widget_MessgeBox(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			_bg = new ExImage(Texture.fromColor(160, 120, 0xFFCCCCCC));
			addChild(_bg);
			
			_text = new TextField(100, 40, "");
			_text.x = 30;
			_text.y = 20;
			addChild(_text);
			
			_button = new Button(Texture.fromColor(40, 20, 0xFFFF0000), "确定");
			_button.x = 60;
			_button.y = 90;
			addChild(_button);
		}
		
		
		public function set text(value:String) : void
		{
			_text.text = value;
		}
		
		public function show(stage:Stage) : void
		{
			stage.addChild(this);		
		}
		
		public function hide() : void
		{
			stage.removeChild(this);
		}
	}
}