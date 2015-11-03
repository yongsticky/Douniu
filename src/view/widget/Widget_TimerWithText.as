package view.widget
{
	import starling.text.TextField;
	
	import view.framework.ExSprite;

	public class Widget_TimerWithText extends ExSprite
	{		
		private var _text:TextField;
		private var _timer:Widget_Timer;
		
		public function Widget_TimerWithText(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{			
			_text = new TextField(320, 48, "", "Microsoft YaHei", 24, 0xE96F0F, true);			
			addChild(_text);
			
			_timer = new Widget_Timer();
			_timer.visible = false;
			_timer.x = 112;
			_timer.y = 60;
			
			addChild(_timer);
		}
		
		public function get text() : TextField
		{
			return _text;
		}
		
		public function get timer() : Widget_Timer
		{
			return _timer;
		}
		
		public function show(textStr:String, time:int) : void
		{			
			visible = true;
			
			_text.text = textStr;
			
			if (time > 0)
			{
				_timer.startTimer(time);
			}
		}
		
		public function hide() : void
		{		
			visible = false;
			
			_timer.stopTimer();			
		}
	}
}