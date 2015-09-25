package view.widget
{
	import resource.ResManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;

	public class Widget_Timer extends ExSprite
	{			
		private var _num:ExImage;		// 数字	
		private var _curTime:int;		//
		
		private var _tween:Tween;
		
		private const MAX_TIMER_NUM:int = 9;
		
		
		private var _running:Boolean;
		
		public function Widget_Timer(name:String = null)
		{
			super(name);
			
			_tween = null;
			_running = false;
		}
		
		override protected function createChildren() : void
		{		
			var bg:ExImage = new ExImage( ResManager.instance().getResourceDev("table.timer_bg"));			
			addChild(bg);
						
			// 70*80
			_num = new ExImage();
			_num.pivotX = 35; 
			_num.pivotY = 40;
			_num.x = bg.width>>1;
			_num.y = bg.height>>1;
			 
			addChild(_num);
		}
		
		public function get running() : Boolean
		{
			return _running;
		}
				
		public function startTimer(time:int) : void
		{	
			_curTime = time<=MAX_TIMER_NUM ? time:MAX_TIMER_NUM;
			
			updateTimerTexture();
			
			doAnimation();					
		}
		
		public function stopTimer() : void
		{
			_curTime = 0;
		}		
						
		protected function onAnimationComplete() : void
		{				
			if (_curTime > 0)
			{
				-- _curTime;				

				updateTimerTexture();
				
				doAnimation();				
			}
			else
			{				
				_running = false;
			}
		}
		
		protected function updateTimerTexture() : void
		{			
			var resId:String = "table.timer_" + _curTime;
			_num.res =  ResManager.instance().getResourceDev(resId); 
			_num.scaleX = _num.scaleY = 1;
		}
		
		protected function doAnimation() : void
		{
			if (_tween)
			{
				_tween.reset(_num, 1, Transitions.EASE_IN_OUT_ELASTIC);
			}
			else
			{
				_tween = new Tween(_num, 1, Transitions.EASE_IN_OUT_ELASTIC);
			}
						
			_tween.scaleTo(0.8);	
			_tween.onComplete = onAnimationComplete;
			
			getOwnerLayer().juggler.add(_tween);
			
			_running = true;
		}
		
	}
}