package view.framework
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class ExSprite extends Sprite
	{
		public function ExSprite()
		{
			super();
			
			stage ? initialize():addEventListener(Event.ADDED_TO_STAGE, function (event:Event) : void {
				event.target.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				initialize();
			});
		}

		protected function initialize() : void
		{
			createChildren();
		}				
		
		protected function createChildren() : void
		{
			throw new Error("Abstract Function.");	
		}
	}
}