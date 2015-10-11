package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;	
	import factory.NiuObjectFactory;	
	import global.RuntimeExchangeData;	
	import packet.game.message.Login.Request_Login;	
	import server.NiuRequestSender;
	
	public class NotificationHandler_SelectRoom extends NiuNotificationHandler
	{
		public function NotificationHandler_SelectRoom(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var roomId:int = int(notification.getData());
			
			_logger.log(this, "User Select Room:[",roomId,"]", LEVEL.DEBUG);
			
			var loginRequest:Request_Login = NiuObjectFactory.instance().createInstance(Request_Login);			
			loginRequest.room_id = roomId;
			loginRequest.uin = loginRequest.csHeader.uin = RuntimeExchangeData.instance().redPlayerData.uin;			
			loginRequest.request_src = 0;
			loginRequest.login_life_style = 0;			
			loginRequest.tlv_num = 0;
			loginRequest.imei_len = 0;
			
			NiuRequestSender.instance().sendRequest(loginRequest);			
		}
	}
}