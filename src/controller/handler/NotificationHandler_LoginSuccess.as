package controller.handler
{		
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.RuntimeSharedData;
	
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Sitdown.Request_Sitdown;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.value.PlayerDetailInfo;
	
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
			var rsd:RuntimeSharedData = RuntimeSharedData.instance();
			rsd.rsdRoomData.room_id = resp.room_id;
			rsd.rsdPlayerData.player_id = resp.player_id;			
			for each(var tlv:UnionTLV in resp.tlv_vec)
			{				
				if (tlv.valueType == TLVType.DN_TLV_PLAYERDETAIL)
				{
					var plInfo:PlayerDetailInfo = tlv.value as PlayerDetailInfo;
					if (plInfo)
					{
						rsd.rsdPlayerData.nick = plInfo.nick;
						rsd.rsdPlayerData.gender = plInfo.gender;
						rsd.rsdPlayerData.chips = plInfo.money.lowPart;						
					}
				}
			}
			
			
			// 开始心跳
			NiuHelloHeartBeat.instance().start();
			
			// 发坐下请求
			var sitdownRequest:Request_Sitdown = NiuObjectFactory.instance().createInstance(Request_Sitdown);			
			sitdownRequest.csHeader.uin = resp.csHeader.uin;
			sitdownRequest.csHeader.dialog_id = resp.player_id;
						
			sitdownRequest.sitdown_flag = 3;
			sitdownRequest.room_id = resp.room_id;
			sitdownRequest.table_id = -1;
			sitdownRequest.seat_id = -1;
						
			NiuRequestSender.instance().sendRequest(sitdownRequest);
			
			NiuDirector.instance().switchToScene(new Scene_Table());
		}
	}
}