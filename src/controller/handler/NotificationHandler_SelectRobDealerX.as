package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.RuntimeExchangeData;
	
	import packet.game.message.Play.Request_Play;
	import packet.game.tv.TVType;
	import packet.game.tv.value.RequestRobDealer;
	
	import server.NiuRequestSender;
	
	public class NotificationHandler_SelectRobDealerX extends NiuNotificationHandler
	{
		public function NotificationHandler_SelectRobDealerX(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute, prepare send RobDealer Request.", LEVEL.DEBUG);
			
			
			var multiple:int = int(notification.getData());
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			var robPref:RequestRobDealer = _factory.createInstance(RequestRobDealer);
			robPref.multiple = multiple;
			
			var requestPlay:Request_Play = _factory.createInstance(Request_Play);
			
			requestPlay.csHeader.uin = requestPlay.uin = RuntimeExchangeData.instance().redPlayerData.uin; 
			requestPlay.csHeader.dialog_id = RuntimeExchangeData.instance().redPlayerData.player_id;
			
			requestPlay.time = (new Date()).getTime();
			
			requestPlay.tv_data.valueType = TVType.SO_REQUEST_DEALER;
			requestPlay.tv_data.value = robPref;			
			
			NiuRequestSender.instance().sendRequest(requestPlay);
		}
	}
}