package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import controller.NiuNotificationHandler;	
	import factory.NiuObjectFactory;	
	import global.GlobalInfo;	
	import packet.game.message.Login.Request_Login;
	import server.NiuRequestSender;
	
	public class NotificationHandler_SelectRoom extends NiuNotificationHandler implements INotificationHandler
	{
		public function NotificationHandler_SelectRoom(mediator:Mediator)
		{
			super(mediator);
		}
		
		public function execute(notification:Notification):void
		{		
		
			var loginRequest:Request_Login = NiuObjectFactory.instance().createInstance(Request_Login);
			
			loginRequest.room_id = int(notification.getData());
			loginRequest.uin = loginRequest.csHeader.uin = GlobalInfo.instance().uin;
			loginRequest.request_src = 0;
			loginRequest.login_life_style = 0;			
			loginRequest.tlv_num = 0;
			loginRequest.imei_len = 0;
			
			NiuRequestSender.instance().sendRequest(loginRequest);			
		}
	}
}