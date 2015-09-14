package view.scene.table.widget
{
	import resource.ResManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.textures.Texture;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;

	public class Widget_Timer extends ExSprite
	{	
		private var _num:ExImage;
		private var _curTime:int;
		
		private var _running:Boolean;
		
		public function Widget_Timer(name:String = null)
		{
			super(name);
			
			_running = false;
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			var bg:ExImage = new ExImage(resManager.getResourceDev("table.timer_bg"));			
			addChild(bg);
			
			var resId:String = "table.timer_" + _curTime;
			var num:ExImage = new ExImage(resManager.getResourceDev(resId));	
			num.pivotX = num.width>>1; 
			num.pivotY = num.height>>1;			
			num.x = width>>1;
			num.y = height>>1;
			
			_num = num;
			addChild(num);
		}
		
		public function get running() : Boolean
		{
			return _running;
		}
				
		public function startTimer(time:int) : void
		{	
			_curTime = time;
			
			updateTimerTexture();
			
			resumeTimer();					
		}
		
		public function stopTimer() : void
		{
			_curTime = 0;		
			
			visible = false;
		}
						
		protected function onCountdownAnimationComplete() : void
		{
			//getOwnerLayer().juggler.removeTweens(this);
			
			if (_curTime > 0)
			{
				--_curTime
					
				updateTimerTexture();				
				resumeTimer();
			}
			else
			{
				_running = false;
			}
		}
		
		protected function updateTimerTexture() : void
		{			
			var resId:String = "table.timer_" + _curTime;
			_num.texture = Texture.fromBitmapData(ResManager.instance().getResourceDev(resId)); 
			_num.scaleX = _num.scaleY = 1;
		}
		
		protected function resumeTimer() : void
		{			
			var tn:Tween = new Tween(_num, 1, Transitions.EASE_IN_OUT_ELASTIC);
			tn.scaleTo(0.8);	
			tn.onComplete = onCountdownAnimationComplete;
			//tn.onCompleteArgs = [tn];
			
			getOwnerLayer().juggler.add(tn);
			
			
			_running = true;
		}
		
	}
}