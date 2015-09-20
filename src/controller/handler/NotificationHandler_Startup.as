package controller.handler
{
	import flash.events.Event;
	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.net.ConnectorEvent;
	
	import controller.NiuNotificationHandler;
	import controller.NiuNotificationHandlerConstant;
	
	import server.NiuResponseReceiver;
	import server.NiuServerConnector;	

	
	public class NotificationHandler_Startup extends NiuNotificationHandler
	{	
		public function NotificationHandler_Startup(mediator:Mediator)
		{
			super(mediator);			
		}
		
		override public function execute(notification:Notification):void
		{
			
			NiuResponseReceiver.instance().initReceivers();
			
			sendNotification(NiuNotificationHandlerConstant.TEST_UI);
			
			
			
			/*
			var connector:NiuServerConnector = NiuServerConnector.instance();	
			connector.setTargetAddress("182.254.40.11", 8000);			
			connector.addEventListener(ConnectorEvent.CONNECTED, onConnect);
			connector.connect();
			*/
			
		}
		
		
		
		protected function onConnect(event:Event):void
		{			
			_logger.log(this, "Connect Server Succ.", LEVEL.INFO);						
			sendNotification(NiuNotificationHandlerConstant.SERVER_CONNECTED);					
		}
	}
}