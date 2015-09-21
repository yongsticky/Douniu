package controller.handler
{	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.SharedData;
	
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Sitdown.Request_Sitdown;
	
	import server.NiuHelloHeartBeat;
	import server.NiuRequestSender;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	
	
	public class NotificationHandler_LoginSuccess extends NiuNotificationHandler
	{		
		public function NotificationHandler_LoginSuccess(mediator:Mediator)
		{
			super(mediator);			
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var resp:Response_Login = notification.getData() as Response_Login;
						
			SharedData.instance().roomId = resp.room_id;
			SharedData.instance().playerId = resp.player_id;
			
			
			var sitdownRequest:Request_Sitdown = NiuObjectFactory.instance().createInstance(Request_Sitdown);		
			
			sitdownRequest.csHeader.uin = resp.csHeader.uin;
			sitdownRequest.csHeader.dialog_id = resp.player_id;
						
			sitdownRequest.sitdown_flag = 3;
			sitdownRequest.room_id = resp.room_id;
			sitdownRequest.table_id = -1;
			sitdownRequest.seat_id = -1;			
			
			NiuRequestSender.instance().sendRequest(sitdownRequest);			
			
			NiuHelloHeartBeat.instance().start();
			
			NiuDirector.instance().switchToScene(new Scene_Table());
		}
	}
}