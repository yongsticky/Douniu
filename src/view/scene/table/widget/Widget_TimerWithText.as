package view.scene.table.widget
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	import view.widget.Widget_Timer;

	public class Widget_TimerWithText extends ExSprite
	{
		private var _text:ExImage;
		private var _timer:Widget_Timer;
		
		public function Widget_TimerWithText(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{			
			_text = new ExImage(/*ResManager.instance().getResourceDev("table.wait_next")*/);			
			addChild(_text);
			
			_timer = new Widget_Timer();						
			_timer.y = 40;	//_text.height + 14;
			addChild(_timer);
		}
		
		public function get text() : ExImage
		{
			return _text;
		}
		
		public function get timer() : Widget_Timer
		{
			return _timer;
		}
		
		public function show(textType:int, time:int) : void
		{
			if (textType == 1)
			{
				_text.res = ResManager.instance().getResourceDev("table.wait_next");
			}
			else if (textType == 2)
			{
				_text.res = ResManager.instance().getResourceDev("table.wait_rob");		
			}
			else
			{
				_text.visible = false;
			}
			
			_timer.startTimer(time);
			
			this.visible = true;
		}
		
		public function hide() : void
		{
			_timer.stopTimer();
			
			this.visible = false;
		}
		
		public function reset(textType:int, time:int) : void
		{
			if (textType == 1)
			{
				_text.res = ResManager.instance().getResourceDev("table.wait_next");
			}
			else if (textType == 2)
			{
				_text.res = ResManager.instance().getResourceDev("table.wait_rob");		
			}
			else
			{
				_text.visible = false;
			}
			
			_timer.resetTimer(time);
		}
	}
}