package view.framework
{
	import starling.animation.Juggler;
	import starling.events.EnterFrameEvent;	

	public class ExLayer extends ExSprite
	{
		private var _juggler:Juggler = null;
		private var _aniPaused:Boolean = false;

		public function ExLayer()
		{
			super();
		}

		override protected function initialize() : void
		{			
			_juggler = new Juggler();
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame)
			
			super.initialize();
		}
		
		public function onStageResize() : void
		{
			
		}

		public function get juggler() : Juggler
		{
			return _juggler;
		}

		protected function onEnterFrame(event:EnterFrameEvent) : void
		{
			if (!_aniPaused)
			{
				_juggler.advanceTime(event.passedTime);
			}
		}
		
		override public function dispose() : void
		{
			_juggler.purge();

			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);

			super.dispose();
		}

		public function pauseAnimation() : void
		{
			_aniPaused = false;
		}

		public function resumeAnimation() : void
		{
			_aniPaused = true;
		}
	}
}