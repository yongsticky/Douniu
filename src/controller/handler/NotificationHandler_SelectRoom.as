package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.SharedData;
	
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
			
			var loginRequest:Request_Login = NiuObjectFactory.instance().createInstance(Request_Login);
			
			loginRequest.room_id = int(notification.getData());
			loginRequest.uin = loginRequest.csHeader.uin = SharedData.instance().uin;			
			loginRequest.request_src = 0;
			loginRequest.login_life_style = 0;			
			loginRequest.tlv_num = 0;
			loginRequest.imei_len = 0;
			
			NiuRequestSender.instance().sendRequest(loginRequest);			
		}
	}
}