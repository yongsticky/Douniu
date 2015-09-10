package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import camu.logger.Logger;
	
	import controller.NiuApplicationFacade;
	
	import starling.core.Starling;
	
	import view.NiuDirector;
	
	[SWF(width="1120", height="780", frameRate="60", backgroundColor="#ffffff")]
	//[SWF(width="640", height="480", frameRate="60", backgroundColor="#ffffff")]
	public class Douniu extends Sprite
	{
		
		private var _starling:Starling = null;
		
		public function Douniu()
		{
			stage ? initialize():addEventListener(Event.ADDED_TO_STAGE, function (event:Event) : void {
				event.target.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				initialize();
			});
		}
		
		
		private function initialize() : void
		{
			Logger.setOff(false);
			
			NiuApplicationFacade.instance().initializeController();
			
			_starling = new Starling(NiuDirector, stage);
			_starling.start();
			
			_starling.showStats = true;
			_starling.antiAliasing = 2;
		}
	}
}