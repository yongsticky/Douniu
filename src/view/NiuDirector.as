package view
{
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.ConnectorEvent;
	
	import controller.NiuNotificationHandlerConstant;
	import controller.NiuNotification;
		
	import server.NiuServerConnector;
	
	import starling.events.EnterFrameEvent;
	
	import view.framework.ExDirector;
	import view.mediator.NiuDirectorMediator;	
	
	public class NiuDirector extends ExDirector
	{
		private var _logger:ILogger = null;
		private var _mediator:NiuDirectorMediator;	
		
		public function NiuDirector()
		{
			super();
			
			if (_instance)
			{
				throw new Error("single class can't create new.");
			}
					
			_instance = this;
			
			_mediator = new NiuDirectorMediator();
			
			_logger = Logger.createLogger(NiuDirector, LEVEL.DEBUG);			
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
		
		public function sendNotification(name:String, data:Object = null) : void
		{			
			_mediator.sendNotification(NiuNotification.createNotification(name, data));
		}
		
		override protected function initialize() : void
		{	
			super.initialize();
			
			_logger.log("initialize called.", LEVEL.INFO);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			sendNotification(NiuNotificationHandlerConstant.STARTUP);				
		}
		
		override protected function createChildren() : void
		{			
		}
		

		
		private function onEnterFrame(event:EnterFrameEvent):void
		{			
			NiuServerConnector.instance().advanceTime(event.passedTime);
		}
	}
}