package view.scene.table.cell
{
	import camu.errors.IndexOutOfRangeError;
		
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	import view.widget.Widget_Timer;

	public class TimerWithText extends ExSprite
	{
		private var _text:ExImage;
		private var _timer:Widget_Timer;
		
		
		private static const INDEX_2_RES:Array = ["table.wait_next.png", "table.wait_rob.png", "table.wait_next.png", "table.wait_rob.png"];
		
		public static const INDEX_WAIT_NEXT:int = 0;
		public static const INDEX_WAIT_ROB_DEALER:int = 1;
		public static const INDEX_WAIT_BET:int = 2;
		public static const INDEX_WAIT_GIVE:int = 3;
		
		
		
		
		public function TimerWithText(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{			
			_text = new ExImage();			
			addChild(_text);
			
			_timer = new Widget_Timer();
			_timer.visible = false;
			_timer.y = 40;
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
		
		public function show(index:int, time:int) : void
		{
			if (index < 0 || index > INDEX_WAIT_GIVE)
			{
				throw new IndexOutOfRangeError();					
			}
			
			visible = true;
			
			//_text.res = ResManager.instance().getResource(INDEX_2_RES[index]);
			
			_timer.startTimer(time);		
		}
		
		public function hide() : void
		{		
			visible = false;
			
			_timer.stopTimer();			
		}
	}
}