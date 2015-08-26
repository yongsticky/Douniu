package view
{
	import camu.design_pattern.Singleton;
	import camu.net.ConnectionEvent;
	import camu.util.log.ILogger;
	import camu.util.log.LogLevel;
	import camu.util.log.Logger;
	import view.framework.ExDirector;
	
	import packet.game.Request_Login;
	
	import server.NiuServerConnection;
	

	import starling.events.EnterFrameEvent;

	
	public class NiuDirector extends ExDirector
	{
		private var _logger:ILogger = null;
		
		public function NiuDirector()
		{
			super();
			
			_logger = Logger.createLogger(NiuDirector, LogLevel.DEBUG);		
			
		}
		
		override protected function initialize():void
		{
			_logger.log("initialize called.", LogLevel.INFO);
			
			super.initialize();	
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			
			var conn:NiuServerConnection = Singleton.instanceOf(NiuServerConnection) as NiuServerConnection;									
			conn.setTargetAddress("182.254.40.11", 8000);			
			conn.addEventListener(ConnectionEvent.CONNECTED, onConnect);
			conn.connect();
			
		}		

		
		private function onEnterFrame(event:EnterFrameEvent):void
		{			
			var conn:NiuServerConnection = Singleton.instanceOf(NiuServerConnection) as NiuServerConnection;
			conn.onTickElapse();
		}
		
		protected function onConnect(event:ConnectionEvent):void
		{
			_logger.log("Connect Server Succ.", LogLevel.INFO);
			
			var conn:NiuServerConnection = event.target as NiuServerConnection;
			
			var packet:Request_Login = conn.objectNew(Request_Login);
			
			_logger.log("Send Request_Login.", LogLevel.INFO);
			conn.send(packet);
		}
	}
}