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
		
		public function Widget_Timer(name:String = null)
		{
			super(name);			
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
				
		public function startTimer(time:int) : void
		{	
			_curTime = time;
			
			updateTimerTexture();
			
			resumeTimer();					
		}
						
		protected function onCountdownAnimationComplete() : void
		{
			getOwnerLayer().juggler.removeTweens(this);
			
			if (_curTime > 0)
			{
				--_curTime
					
				updateTimerTexture();				
				resumeTimer();
			}
			else
			{
				visible = true;
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
			
			getOwnerLayer().juggler.add(tn);
		}
		
	}
}