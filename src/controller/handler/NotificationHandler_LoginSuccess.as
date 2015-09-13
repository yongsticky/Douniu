package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.GlobalInfo;
	
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Sitdown.Request_Sitdown;
	
	import server.NiuHelloHeartBeat;
	import server.NiuRequestSender;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	
	
	public class NotificationHandler_LoginSuccess extends NiuNotificationHandler implements INotificationHandler
	{
		public function NotificationHandler_LoginSuccess(mediator:Mediator)
		{
			super(mediator);
		}
		
		public function execute(notification:Notification) : void
		{
			var resp:Response_Login = notification.getData() as Response_Login;			
			
			var sitdownRequest:Request_Sitdown = NiuObjectFactory.instance().createInstance(Request_Sitdown);
			
			sitdownRequest.csHeader.uin = GlobalInfo.instance().uin;
			sitdownRequest.csHeader.dialog_id = GlobalInfo.instance().playerId;
			sitdownRequest.sitdown_flag = 3;
			sitdownRequest.room_id = int(notification.getData());
			
			NiuRequestSender.instance().sendRequest(sitdownRequest);			
			
			NiuHelloHeartBeat.instance().start();
			
			NiuDirector.instance().switchToScene(new Scene_Table());
		}
	}
}