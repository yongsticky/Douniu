package controller.handler
{		
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import facade.NiuNotificationHandlerConstant;
	
	import packet.game.message.Login.Response_Login;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.value.LockInfo;
	
	import view.widget.MessageBoxHelper;
	
	public class NotificationHandler_LoginFailed extends NiuNotificationHandler
	{
		public function NotificationHandler_LoginFailed(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var resp:Response_Login = notification.getData() as Response_Login;
			
			// locked
			if (resp.rresult.result_id == 10509)
			{
				for (var i:int = 0; i < resp.tlv_num; ++i)
				{
					if (resp.tlv_vec[i].valueType == TLVType.DN_TLV_LOCK_INFO)
					{
						var lockInfo:LockInfo = resp.tlv_vec[i].value as LockInfo;
						if (lockInfo)
						{
							sendNotification(NiuNotificationHandlerConstant.ENTER_ROOM, lockInfo.locked_room_id);
							return;
						}
					}
				}
			}
			
			MessageBoxHelper.showMessageBox("登录房间失败，错误码："+resp.rresult.result_id, "确定");
		}
	}
}