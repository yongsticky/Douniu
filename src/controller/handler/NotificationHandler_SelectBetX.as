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
	import packet.game.tv.value.RequestBet;
	
	import server.NiuRequestSender;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_TableMain;
	
	public class NotificationHandler_SelectBetX extends NiuNotificationHandler
	{
		public function NotificationHandler_SelectBetX(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var multiple:int = int(notification.getData());
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();			
			var betPref:RequestBet = _factory.createInstance(RequestBet);
			betPref.multiple = multiple;
			
			var requestPlay:Request_Play = _factory.createInstance(Request_Play);
			requestPlay.csHeader.uin = requestPlay.uin = RuntimeExchangeData.instance().redPlayerData.uin; 
			requestPlay.csHeader.dialog_id = RuntimeExchangeData.instance().redPlayerData.player_id;
			
			requestPlay.time = (new Date()).getTime();
			
			requestPlay.tv_data.valueType = TVType.SO_REQUEST_BET;
			requestPlay.tv_data.value = betPref;
			
			NiuRequestSender.instance().sendRequest(requestPlay);	
			

			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			if (layer)
			{					
				layer.getPlayer().hideBetButtonGroup();
				layer.hideTimer();				
			}
		}
	}
}