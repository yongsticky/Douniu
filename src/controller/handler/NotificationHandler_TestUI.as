package controller.handler
{
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import douniu.NiuSuggest;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_TableMain;
	
	public class NotificationHandler_TestUI extends NiuNotificationHandler
	{
		private var _first:Boolean = true;
		
		public function NotificationHandler_TestUI(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			var scene:Scene_Table = new Scene_Table();
			NiuDirector.instance().switchToScene(scene);
						
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			
			layer.getPlayer().show("3000011", 10000, 0);
			//layer.getPlayer().flowMoneyChangeText(3000);
			//layer.getPlayer().showBetNotify(5);
			var tiles:ByteArray = new ByteArray();
			tiles[0] = 9;
			tiles[1] = 15;
			tiles[2] = 10;
			tiles[3] = 27;
			tiles[4] = 52;
			layer.getPlayer().showCards(tiles);
			//layer.getPlayer().showNiuResult(NiuSuggest.getSuggestObject(tiles)["niuType"]);
			//layer.getPlayer().showReadyButtonGoroup();
			
			layer.getPlayer().showBetMultiple(4);
			
			
			layer.getOtherPlayer(1).show("11111111", 12000, 0);
			//layer.getOtherPlayer(1).showBetNotify(10);
			//layer.getOtherPlayer(1).showRobDealerNotify(true);
			layer.getOtherPlayer(1).showCards(tiles);
			layer.getOtherPlayer(1).showBetMultiple(8);
			//layer.getOtherPlayer(1).showNiuResult(NiuSuggest.getSuggestObject(tiles)["niuType"]);
			//layer.getOtherPlayer(1).flowMoneyChangeText(-3000);	
			//layer.getOtherPlayer(1).setAsDealer();
			
			//layer.getOtherPlayer(2).show("222222", 12000, 0);
			//layer.getOtherPlayer(2).showCards(new <int>[11,21,31,33,35]);
			//layer.getOtherPlayer(2).flowMoneyChangeText(-3000);
			
			
			
			//layer.getOtherPlayer(3).show("333333", 12000, 0);
			//layer.getOtherPlayer(3).showBetNotify(2);
			//layer.getOtherPlayer(3).showRobDealerNotify(false);
			//layer.getOtherPlayer(3).showCards(new <int>[11,21,31,33,35]);
			//layer.getOtherPlayer(3).flowMoneyChangeText(-3000);	
			
			//layer.getOtherPlayer(4).show("44444444", 12000, 0);
			//layer.getOtherPlayer(4).showBetNotify(100);
			//layer.getOtherPlayer(4).showRobDealerNotify(true);
			//layer.getOtherPlayer(4).showCards(new <int>[11,21,31,33,35]);
			//layer.getOtherPlayer(4).flowMoneyChangeText(-3000);
			
			layer.getOtherPlayer(5).show("55555555", 12000, 0);
			layer.getOtherPlayer(5).showCards(tiles);			
			layer.getOtherPlayer(5).showBetMultiple(99);
			//layer.getOtherPlayer(5).flowMoneyChangeText(-3000);
			//layer.getOtherPlayer(5).showNiuResult(NiuSuggest.getSuggestObject(tiles)["niuType"]);
		}			
	}
}