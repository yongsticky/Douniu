package
{
	import flash.display.Sprite;
	import flash.events.Event;	
	
	import starling.core.Starling;
	
	import camu.logger.Logger;	
	
	import facade.NiuApplicationFacade;	
	import view.NiuDirector;
	
	[SWF(width="1220", height="900", frameRate="60", backgroundColor="#222222")]
	//[SWF(width="640", height="480", frameRate="60", backgroundColor="#ffffff")]
	public class douniu extends Sprite
	{		
		private var _starling:Starling = null;
		
		public function douniu()
		{
			stage ? initialize():addEventListener(Event.ADDED_TO_STAGE, function (event:Event) : void {
				event.target.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				initialize();
			});
		}		
		
		private function initialize() : void
		{			
			Logger.setOff(false);
									
			// 初始化controller handlers
			NiuApplicationFacade.instance().initializeNotificationHandlers();			
			
			_starling = new Starling(NiuDirector, stage);			
			_starling.start();			
			_starling.showStats = true;
			_starling.antiAliasing = 2;
		}
	}
}