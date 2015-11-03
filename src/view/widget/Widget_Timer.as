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
		
		private const MAX_TIMER_NUM:int = 5;
				
		
		public function Widget_Timer(name:String = null)
		{
			super(name);
			
			_tween = null;
		}
		
		override protected function createChildren() : void
		{		
			// 82*82
			_bg = new ExImage( ResManager.instance().getResource("ui.timer_bg"));				
			addChild(_bg);
						
			// 37*33
			_num = new ExImage();
			_num.pivotX = 18.5; 
			_num.pivotY = 16.5;
			_num.x = _bg.width>>1;
			_num.y = _bg.height>>1;
			 
			addChild(_num);
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
		}
		
		private function _startTimer(time:int, caller:int) : void
		{
			if (caller == 1)
			{
				_delayCall = null;
			}
			
			_curTime = time;
			
			visible = true;			
						
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

				doAnimation();
			}			
		}
				
		protected function doAnimation() : void
		{
			var resId:String = "ui.timer_" + _curTime;
			_num.res =  ResManager.instance().getResource(resId); 
			_num.scaleX = _num.scaleY = 1.4;


			if (_tween)
			{
				_tween.reset(_num, 1, Transitions.EASE_IN_OUT_ELASTIC);
			}
			else
			{
				_tween = new Tween(_num, 1, Transitions.EASE_IN_OUT_ELASTIC);
			}
					
			_tween.scaleTo(1);	
			_tween.onComplete = onAnimationComplete;
			
			getOwnerLayer().juggler.add(_tween);
		}
		
	}
}