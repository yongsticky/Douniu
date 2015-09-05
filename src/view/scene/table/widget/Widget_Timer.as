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
		
		public function Widget_Timer(timeStart:int)
		{
			super();
			
			_curTime = timeStart;
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			var bg:ExImage = new ExImage(resManager.getResourceDev("table.timer_bg"));			
			addChild(bg);
			
			var resId:String = "table.timer_" + _curTime;
			var num:ExImage = new ExImage(resManager.getResourceDev(resId));	
			num.pivotX = num.pivotY = 0.5;
			
			num.x = width/2 - 28;
			num.y = height/2 - 34;
			
			_num = num;
			addChild(num);
		}
		
		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
		
		public function startTimer() : void
		{				
			var tn:Tween = new Tween(_num, 1, Transitions.EASE_IN);
			tn.scaleTo(0.8);			
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