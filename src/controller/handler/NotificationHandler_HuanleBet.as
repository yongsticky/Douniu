package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import factory.NiuObjectFactory;
	
	import global.RuntimeExchangeData;
	import global.structs.REDPlayerData;
	
	import packet.game.message.Play.Request_Play;
	import packet.game.tv.TVType;
	import packet.game.tv.value.RequestBet;
	
	import server.NiuRequestSender;
	
	import view.NiuDirector;
	import view.scene.huanle.Scene_HuanLeTable;
	import view.scene.huanle.layer.Layer_HuanleMain;
	
	public class NotificationHandler_HuanleBet extends NiuNotificationHandler
	{
		public function NotificationHandler_HuanleBet(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification) : void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var multiple:int = 1;
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();			
			var betPref:RequestBet = _factory.createInstance(RequestBet);
			betPref.multiple = multiple;
			
			var requestPlay:Request_Play = _factory.createInstance(Request_Play);
			var redp:REDPlayerData = RuntimeExchangeData.instance().redPlayerData;
			requestPlay.csHeader.uin = requestPlay.uin = redp.uin; 
			requestPlay.csHeader.dialog_id = redp.player_id;
			
			requestPlay.time = (new Date()).getTime();
			
			requestPlay.tv_data.valueType = TVType.SO_REQUEST_BET;
			requestPlay.tv_data.value = betPref;
			
			NiuRequestSender.instance().sendRequest(requestPlay);
			
			var scene:Scene_HuanLeTable = NiuDirector.instance().topScene as Scene_HuanLeTable;
			if (scene)
			{
				var layer:Layer_HuanleMain = scene.getChildByName(Scene_HuanLeTable.LAYER_MAIN) as Layer_HuanleMain;
				if (layer)
				{					
					layer.hideBetButton();
				}
			}
		}
	}
}