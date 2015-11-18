package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import camu.logger.Logger;
	
	import facade.NiuApplicationFacade;
	
	import global.RuntimeExchangeData;
	import global.structs.REDPlayerData;
	
	import starling.core.Starling;
	import starling.events.ResizeEvent;
	
	import view.NiuDirector;
	
	[SWF(width="1120", height="780", frameRate="60", backgroundColor="#222222")]	
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
						
			readFrameParameters();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(flash.events.Event.RESIZE, onFrameResize);
			
			_starling = new Starling(NiuDirector, stage);
			_starling.start();			
			_starling.showStats = true;			
			_starling.antiAliasing = 2;	
			
		}
		
		protected function onFrameResize(event:Event):void
		{
			var e:ResizeEvent = new ResizeEvent(ResizeEvent.RESIZE, stage.stageWidth, stage.stageHeight);			
			_starling.stage.dispatchEvent(e);
			
			event.stopImmediatePropagation();
		}	
		
		private function readFrameParameters() : void
		{
			var flashVars:Object = stage.loaderInfo.parameters;
			if (flashVars)
			{
				NiuApplicationFacade.instance().initializeNotificationHandlers();
				
				var redp:REDPlayerData = RuntimeExchangeData.instance().redPlayerData;
				if (flashVars.hasOwnProperty("uin"))
				{
					redp.uin = uint(flashVars["uin"]);
				}
				
				if (flashVars.hasOwnProperty("nick"))
				{
					redp.nick = flashVars["nick"];	
				}
				
				if (flashVars.hasOwnProperty("sid"))
				{
					redp.sid = flashVars["sid"];
				}
				
				if (flashVars.hasOwnProperty("gold"))
				{
					redp.money = int(flashVars["gold"]);
				}
				
				if (flashVars.hasOwnProperty("quan"))
				{
					redp.note = int(flashVars["quan"]);
				}
				
				if (flashVars.hasOwnProperty("locked"))
				{
					redp.locked_room = int(flashVars["locked"]);
				}
			}
			
		}
		
	}
}