package view
{
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.mvc.Notification;
	import camu.net.ConnectorEvent;
	
	import controller.NiuHandlerConstant;
	import controller.NiuNotification;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.Login.Request_Login;
	
	import server.NiuRequestSender;
	import server.NiuResponseReceiver;
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
		
		public function sendNotification(name:String, data:Object) : void
		{			
			_mediator.sendNotification(NiuNotification.createNotification(name, data));
		}
		
		override protected function initialize() : void
		{	
			super.initialize();
			
			_logger.log("initialize called.", LEVEL.INFO);
						
			//connectGameServer();
			
			//NiuResponseReceiver.instance().initReceiver();			
			
			sendNotification(NiuHandlerConstant.ENTER_HALL, null);
		}
		
		override protected function createChildren() : void
		{
			//switchToScene(new Scene_Hall());
		}
		
		private function connectGameServer() : void
		{
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			var connector_:NiuServerConnector = NiuServerConnector.instance();	
			connector_.setTargetAddress("182.254.40.11", 8000);			
			connector_.addEventListener(ConnectorEvent.CONNECTED, onConnect);
			connector_.connect();
		}
		
		private function onEnterFrame(event:EnterFrameEvent):void
		{			
			NiuServerConnector.instance().advanceTime(event.passedTime);
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
			
			NiuRequestSender.instance().sendRequest(loginRequest);
		}

		override protected function layoutChildren() : void
		{
			
		}
	}
}