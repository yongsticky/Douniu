package controller.handler
{
	import flash.events.Event;
	
	import camu.logger.Logger;
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	import camu.net.ConnectorEvent;
	
	import controller.NiuNotificationHandler;
	import controller.NiuNotificationHandlerConstant;
	
	import server.NiuResponseReceiver;
	import server.NiuServerConnector;	
	
	public class NotificationHandler_Startup extends NiuNotificationHandler implements INotificationHandler
	{
		private var _logger:ILogger;
		
		public function NotificationHandler_Startup(mediator:Mediator)
		{
			super(mediator);
			
			_logger = Logger.createLogger(NotificationHandler_Startup, LEVEL.INFO);
		}
		
		public function execute(notification:Notification):void
		{			
			NiuResponseReceiver.instance().initReceiver();
			
			var connector_:NiuServerConnector = NiuServerConnector.instance();	
			connector_.setTargetAddress("182.254.40.11", 8000);			
			connector_.addEventListener(ConnectorEvent.CONNECTED, onConnect);
			connector_.connect();
		}
		
		protected function onConnect(event:Event):void
		{
			
			_logger.log("Connect Server Succ.", LEVEL.INFO);				
						
			sendNotification(NiuNotificationHandlerConstant.SERVER_CONNECTED);					
		}
	}
}