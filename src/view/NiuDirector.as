package view
{
	import camu.errors.AbstractClassError;
	import camu.logger.LEVEL;
	
	import controller.NiuNotification;
	
	import facade.NiuNotificationHandlerConstant;
	
	import server.NiuServerConnector;
	
	import starling.events.EnterFrameEvent;
	
	import view.framework.ExDirector;
	import view.framework.ExLayer;
	
	public class NiuDirector extends ExDirector
	{		
		private var _mediator:NiuViewMediator;	
		
		public function NiuDirector()
		{
			super();
			
			if (_instance)
			{
				throw new AbstractClassError();				
			}
					
			_instance = this;
			
			_mediator = new NiuViewMediator();
		}
		
		private static var _instance:NiuDirector = null;
		public static function instance() : NiuDirector
		{
			if (!_instance)
			{
				_instance = new NiuDirector();
			}
			
			return _instance;
		}	
		
		public function getLayerInCurrentTopScene(layerName:String) : ExLayer
		{
			if (topScene)
			{
				return topScene.getChildByName(layerName) as ExLayer;
			}
			else
			{
				return null;
			}
		}
		
		public function sendNotification(name:String, data:Object = null) : void
		{			
			_mediator.sendNotification(NiuNotification.createNotification(name, data));
		}
		
		override protected function initialize() : void
		{	
			super.initialize();
						
			_logger.log(this, "initialize called.", LEVEL.INFO);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);			
			
			sendNotification(NiuNotificationHandlerConstant.STARTUP);				
		}
		
		override protected function createChildren():void
		{
			
		}
		
		private function onEnterFrame(event:EnterFrameEvent):void
		{			
			NiuServerConnector.instance().advanceTime(event.passedTime);
		}
	}
}