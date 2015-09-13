package controller.handler
{
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.Login.Request_Login;
	
	import server.NiuRequestSender;
	
	import controller.NiuHandlerConstant;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	
	public class NotificationHandler_EnterRoom implements INotificationHandler
	{
		public function NotificationHandler_EnterRoom()
		{
		}
		
		public function execute(notification:Notification):void
		{
			/*
			var rid:int = notification.getData().rid;
			
			var sceneTable:Scene_Table = new Scene_Table("scene.table");
			NiuDirector.instance().switchToScene(sceneTable);
			
			NiuDirector.instance().sendNotification(NiuHandlerConstant.PLAYER_ENTER);
			
			NiuDirector.instance().sendNotification(NiuHandlerConstant.OTHERPLAYER_ENTER);
			*/
			
			
			var loginRequest:Request_Login = NiuObjectFactory.instance().createInstance(Request_Login);
			
			loginRequest.room_id = 76;
			loginRequest.uin = loginRequest.csHeader.uin = int(notification.getData()["uin"]);
			loginRequest.request_src = 0;
			loginRequest.login_life_style = 0;			
			loginRequest.tlv_num = 0;
			loginRequest.imei_len = 0;
			
			NiuRequestSender.instance().sendRequest(loginRequest);			
		}
	}
}