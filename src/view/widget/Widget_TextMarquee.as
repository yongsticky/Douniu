package view.widget
{
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import starling.text.TextField;
	
	import view.framework.ExSprite;
	
	public class Widget_TextMarquee extends ExSprite
	{
		private var _textVec:Vector.<String>;		
		private var _tf:TextField;
		private var _timer:Timer;	
		private var _spriteWidth:int;
		private var _spriteHeight:int;
		private var _step:int;
		
		private static const DEFAULT_TEXTFIELD_WIDTH:int = 340;
		private static const DEFAULT_TEXTFIELD_HEIGHT:int = 25;
		
		public function Widget_TextMarquee(width:int, height:int, name:String = null)
		{
			super(name);
			
			_spriteWidth = width;
			_spriteHeight = height;
			
			_textVec = new Vector.<String>();
			
			_timer = new Timer(20);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		override protected function createChildren() : void
		{
			_step = 1;
			
			_tf = new TextField(_spriteWidth, _spriteHeight, "");
			_tf.x = 0;
			_tf.hAlign = "left";			
			addChild(_tf);
			
			this.clipRect = new Rectangle(0, 0, _spriteWidth, _spriteHeight);
		}
		
		override public function dispose():void
		{
			if (_timer.running)
			{
				_timer.stop();
			}
		}
		
		protected function onTimer(event:TimerEvent) : void
		{
			if (_tf.x > -_tf.textBounds.width)
			{				
				_tf.x -= _step;				
			}
			else
			{				
				if (_textVec.length > 0)
				{
					_tf.text = _textVec.shift();
					_tf.x = _spriteWidth;
					addChild(_tf);
				}
				else
				{
					_timer.stop();
				}
			}
		}
		
		
		protected function doUpdate() : void
		{
			// already running
			if (!_timer.running)
			{				
				_timer.start();
			}			
		}
		
		public function add(text:String) : void
		{
			_textVec.push(text);
			
			doUpdate();
		}		
		
		public function set textFontName(fontName:String) : void
		{
			_tf.fontName = fontName;
		}
		
		public function set textFontSize(fontSize:int) : void
		{
			_tf.fontSize = fontSize;			
		}
		
		public function set textColor(color:uint) : void
		{
			_tf.color = textColor;
		}
		
		public function set textBold(bold:Boolean) : void
		{
			_tf.bold = bold;
		}
	}
}