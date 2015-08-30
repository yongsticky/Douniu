package view
{
	import starling.events.EnterFrameEvent;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.ConnectionEvent;
	
	import factory.NiuObjectFactory;	
	import packet.game.message.Login.Request_Login;	
	import server.NiuServerConnection;	
	import view.framework.ExDirector;

	
	public class NiuDirector extends ExDirector
	{
		private var _logger:ILogger = null;
		
		public function NiuDirector()
		{
			super();
			
			_logger = Logger.createLogger(NiuDirector, LEVEL.DEBUG);		
			
		}
		
		override protected function initialize() : void
		{	
			_logger.log("initialize called.", LEVEL.INFO);
			
			super.initialize();			
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);			
			
			var connector:NiuServerConnection = NiuServerConnection.instance();	
			connector.setTargetAddress("182.254.40.11", 8000);			
			connector.addEventListener(ConnectionEvent.CONNECTED, onConnect);
			connector.connect();
		}

		
		private function onEnterFrame(event:EnterFrameEvent):void
		{			
			NiuServerConnection.instance().onTickElapse();
		}
		
		protected function onConnect(event:ConnectionEvent):void
		{
			_logger.log("Connect Server Succ.", LEVEL.INFO);			
			var packet:Request_Login = NiuObjectFactory.instance().createInstance(Request_Login);
			
			_logger.log("Send Request_Login.", LEVEL.INFO);			
			NiuServerConnection.instance().send(packet);
		}
	}
}