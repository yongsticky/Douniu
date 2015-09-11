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
		
		public function Widget_Timer(timeStart:int, name:String = null)
		{
			super(name);
			
			_curTime = timeStart;
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
				
		public function startTimer() : void
		{				
			var tn:Tween = new Tween(_num, 1, Transitions.EASE_IN_OUT_ELASTIC);
			tn.scaleTo(0.85);	
			tn.onComplete = onCountdownAnimationComplete;
			
			getOwnerLayer().juggler.add(tn);			
		}
		
		protected function onCountdownAnimationComplete() : void
		{
			if (_curTime > 0)
			{
				_curTime --;
				updateTimer();
				
				startTimer();
			}
			else
			{
				parent.removeChild(this, true);
			}
		}
		
		protected function updateTimer() : void
		{
			var resId:String = "table.timer_" + _curTime;
			_num.texture = Texture.fromBitmapData(ResManager.instance().getResourceDev(resId)); 
			_num.scaleX = _num.scaleY = 1;
		}
	}
}