package controller.handler
{	
	import flash.events.Event;
	import flash.net.Socket;
	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.net.ConnectorEvent;
	
	import controller.NiuNotificationHandler;
	
	import facade.NiuNotificationHandlerConstant;
	
	import global.ProgramConfiguration;
	
	import server.NiuResponseReceiver;
	import server.NiuServerConnector;
	
	import sound.SoundManager;
	
	public class NotificationHandler_Startup extends NiuNotificationHandler
	{	
		public function NotificationHandler_Startup(mediator:Mediator)
		{
			super(mediator);			
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			NiuResponseReceiver.instance().initReceivers();
			
			//sendNotification(NiuNotificationHandlerConstant.TEST_UI);	
						
			
			var connector:NiuServerConnector = NiuServerConnector.instance();	
			
			var host:String = ProgramConfiguration.instance().serverHost;
			var port:int = ProgramConfiguration.instance().serverPort;
			connector.setTargetAddress(host, port);
			connector.addEventListener(ConnectorEvent.CONNECTED, onConnect);
			connector.addEventListener(ConnectorEvent.IO_ERROR, onIoError);
			connector.addEventListener(ConnectorEvent.SECURITY_ERROR, onSecurityError);
			connector.addEventListener(ConnectorEvent.SERVER_CLOSED, onServerClosed);
			connector.connect();
						
			_logger.log(this, "Connect to Server[", host, ":", port, "].", LEVEL.INFO);			
		}		
	
		protected function onConnect(event:Event):void
		{			
			_logger.log(this, "Connect server succ.", LEVEL.INFO);			
			sendNotification(NiuNotificationHandlerConstant.SERVER_CONNECTED);		
		}
		
		protected function onIoError(event:ConnectorEvent):void
		{						
		}
		
		protected function onSecurityError(event:ConnectorEvent):void
		{			
		}
		
		protected function onServerClosed(event:ConnectorEvent):void
		{
							
		}
	}
}