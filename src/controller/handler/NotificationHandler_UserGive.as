package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.RuntimeSharedData;
	
	import packet.game.message.Play.Request_Play;
	import packet.game.tv.TVType;
	import packet.game.tv.value.RequestGive;
	
	import server.NiuRequestSender;
	
	public class NotificationHandler_UserGive extends NiuNotificationHandler
	{
		public function NotificationHandler_UserGive(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var selectedVec:Vector.<int> = notification.getData() as Vector.<int>;
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			
			var givePref:RequestGive = _factory.createInstance(RequestGive);
			givePref.tiles_num = selectedVec.length;
			for (var i:int = 0; i < selectedVec.length; ++i)
			{
				givePref.tiles.writeByte(selectedVec[i]);
			}
			
			var requestPlay:Request_Play = _factory.createInstance(Request_Play);
			requestPlay.csHeader.uin = requestPlay.uin = RuntimeSharedData.instance().rsdPlayerData.uin;
			requestPlay.csHeader.dialog_id = RuntimeSharedData.instance().rsdPlayerData.player_id;
			
			requestPlay.tv_data.valueType = TVType.SO_REQUEST_GIVE;
			requestPlay.tv_data.value = givePref;
			
			NiuRequestSender.instance().sendRequest(requestPlay);
			
		}
	}
}