package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.GlobalSharedData;
	
	import packet.game.message.Play.Request_Play;
	import packet.game.tv.TVType;
	import packet.game.tv.value.RequestBet;
	
	import server.NiuRequestSender;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_GameTable;
	
	public class NotificationHandler_SelectBetX extends NiuNotificationHandler
	{
		public function NotificationHandler_SelectBetX(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute Enter.", LEVEL.INFO);
			
			var multiple:int = int(notification.getData());
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();			
			var betPref:RequestBet = _factory.createInstance(RequestBet);
			betPref.multiple = multiple;
			
			var requestPlay:Request_Play = _factory.createInstance(Request_Play);
			requestPlay.csHeader.uin = requestPlay.uin = GlobalSharedData.instance().uin; 
			requestPlay.csHeader.dialog_id = GlobalSharedData.instance().playerId;
			
			requestPlay.time = (new Date()).getTime();
			
			requestPlay.tv_data.valueType = TVType.SO_REQUEST_BET;
			requestPlay.tv_data.value = betPref;
			
			NiuRequestSender.instance().sendRequest(requestPlay);	
			
			var sceneTable:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			if (sceneTable)
			{
				var layerTable:Layer_GameTable = sceneTable.getChildByNameWithRecursive("table.table") as Layer_GameTable;
				if (layerTable)
				{					
					layerTable.hideBetButtonGroup();
					layerTable.hideTimer();				
				}
			}
		}
	}
}