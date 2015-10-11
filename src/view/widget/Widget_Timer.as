package view.widget
{
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.animation.IAnimatable;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;

	public class Widget_Timer extends ExSprite
	{	
		private var _bg:ExImage;		// 背景
		private var _num:ExImage;		// 数字	
		private var _curTime:int;		//
		
		private var _tween:Tween;
		
		private var _delayCall:IAnimatable;
		
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
			_bg = new ExImage( ResManager.instance().getResourceDev("table.timer_bg"));				
			addChild(_bg);
						
			// 70*80
			_num = new ExImage();
			_num.pivotX = 35; 
			_num.pivotY = 40;
			_num.x = _bg.width>>1;
			_num.y = _bg.height>>1;
			 
			addChild(_num);
		}
		
		public function get running() : Boolean
		{
			return _running;
		}
				
		public function startTimer(time:int) : void
		{	
			if (_delayCall)
			{
				getOwnerLayer().juggler.remove(_delayCall);	
				_delayCall = null;
			}
			
			if (time > MAX_TIMER_NUM)
			{
				stopTimer();
				
				_delayCall = getOwnerLayer().juggler.delayCall(_startTimer, time-MAX_TIMER_NUM, MAX_TIMER_NUM, 1);
			}
			else
			{
				_startTimer(time, 0);
			}
			
			//_curTime = time<=MAX_TIMER_NUM ? time:MAX_TIMER_NUM;
			
			
			
			//updateTimerTexture();
			
			//doAnimation();					
		}
		
		private function _startTimer(time:int, caller:int) : void
		{
			if (caller == 1)
			{
				_delayCall = null;
			}
			
			_curTime = time;
			
			visible = true;			
			
			updateTimerTexture();
			doAnimation();
			
			SoundManager.instance().playTimerWarning();
		}
		
		public function stopTimer() : void
		{
			visible = false;
			
			if (_delayCall)
			{
				getOwnerLayer().juggler.remove(_delayCall);
				_delayCall = null;
			}
			
			_curTime = 0;
		}		
						
		protected function onAnimationComplete() : void
		{				
			if (_curTime > 0)
			{
				SoundManager.instance().playTimerRun();
				
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