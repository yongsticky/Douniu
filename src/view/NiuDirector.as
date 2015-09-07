package view
{
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.ConnectorEvent;
	import camu.singleton.Singleton;
	
	import factory.NiuObjectFactory;
		
	import packet.game.message.Login.Request_Login;
	
	import server.NiuServerConnector;
	import server.NiuServerRequestSender;
	import server.NiuServerResponseReceiver;
	
	import starling.events.EnterFrameEvent;
	
	import view.framework.ExDirector;
	import view.scene.hall.Scene_Hall;
	import view.scene.setting.Scene_Setting;


	
	public class NiuDirector extends ExDirector
	{

		private var _logger:ILogger = null;
		
		public function NiuDirector()
		{
			super();
			
			_logger = Logger.createLogger(NiuDirector, LEVEL.DEBUG);
			
			Singleton.add(this);
			
		}
		
		public static function instance() : ExDirector
		{
			return Singleton.instanceOf(NiuDirector);
		}		
		
		
		override protected function initialize() : void
		{	
			super.initialize();
			
			_logger.log("initialize called.", LEVEL.INFO);					
						
			connectGameServer();
			
			NiuServerResponseReceiver.instance().initReceiver();
		}
		
		override protected function createChildren() : void
		{
			//switchToScene(new Scene_Hall());
		}
		
		private function connectGameServer() : void
		{
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			var connector:NiuServerConnector = NiuServerConnector.instance();	
			connector.setTargetAddress("182.254.40.11", 8000);			
			connector.addEventListener(ConnectorEvent.CONNECTED, onConnect);
			connector.connect();
		}
		
		private function onEnterFrame(event:EnterFrameEvent):void
		{			
			NiuServerConnector.instance().onTickElapse();
		}
		
		protected function onConnect(event:ConnectorEvent):void
		{
			_logger.log("Connect Server Succ.", LEVEL.INFO);	
			
			
			var loginRequest:Request_Login = NiuObjectFactory.instance().createInstance(Request_Login);			

			loginRequest.room_id = 76;
			loginRequest.uin = loginRequest.csHeader.uin = 700033;
			loginRequest.request_src = 0;
			loginRequest.login_life_style = 0;
			loginRequest.room_id = 76;
			loginRequest.tlv_num = 0;
			loginRequest.imei_len = 0;
			
			NiuServerRequestSender.instance().sendRequest(loginRequest);
		}

		override protected function layoutChildren() : void
		{
			
		}
	}
}