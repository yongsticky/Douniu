package view.scene.table.widget
{
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
			
		}
		
		
	}
}