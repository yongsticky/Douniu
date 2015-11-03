package controller.handler
{
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
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
			
			layer.showPlayer("3000011", 10000, 0);
			layer.getPlayer().setMoneyChange(3000);
			
			layer.showOtherPlayer("3000012", 12000, 3);
			layer.showOtherPlayerCards(new <int>[11,21,31,33,35], 3);
			layer.getOtherPlayer(3).setMoneyChange(-3000);
			
			
			//layer.showPlayerCards(new <int>[11,21,31,33,35]);
			
			//layer.getPlayer().setMoneyChange(1000);
			
			
			//layer.showPlayerReadyButtonGroup();
			
			
			/*
			layer.showPlayerCards(new <int>[11,21,31,33,35]);
			
			
			
			layer.setAnyPlayerAsDealer(0, 5);
			layer.showPlayerGiveButtonGroup();
			layer.showCardCalculater();
			layer.showOtherPlayer("3000012", 12000, 1);
			layer.showOtherPlayerCards(new <int>[11,21,31,33,35], 1);
			
			layer.showOtherPlayer("3000013", 12000, 2);
			layer.showOtherPlayerCards(new <int>[0,0,0,0,0], 2);			
			
			
			layer.showOtherPlayer("3000014", 12000, 3);
			layer.showOtherPlayerCards(new <int>[0,0,0,0,0], 3);
			
			layer.showOtherPlayer("3000015", 12000, 4);
			layer.showOtherPlayerCards(new <int>[0,0,0,0,0], 4);
			layer.showOtherPlayer("3000016", 12000, 5);		
			layer.showOtherPlayerCards(new <int>[0,0,0,0,0], 5);
			
			layer.setAnyPlayerAsDealer(1, 2);
			layer.setAnyPlayerAsDealer(2, 2);
			layer.setAnyPlayerAsDealer(3, 2);
			layer.setAnyPlayerAsDealer(4, 2);
			layer.setAnyPlayerAsDealer(5, 2);
			
			
			
			
			layer.showWaitNextTimer(8);
			*/
			
			/*var timer:Timer = new Timer(3000, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);			
			timer.start();
			*/			
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			
			layer.setAnyPlayerRobDealerState(1, false);
		}
		
		/*
		protected function onTimer(event:TimerEvent):void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
		var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
	

			if (_first)
			{				
				layer.showPlayerCards(new <int>[1, 2, 3, 4, 5]);
				layer.showOtherPlayerCards(new <int>[0, 0, 0, 0, 0]);
				
				layer.hideTimer();
				
				layer.showWaitBetTimer(8);
				
				_first = false;
				
				var timer:Timer = new Timer(200, 1);
				timer.addEventListener(TimerEvent.TIMER, onTimer2);				
			}
			else
			{
				layer.showPlayerCards(new <int>[21, 32, 33, 34, 0]);
				layer.showOtherPlayerCards(new <int>[30, 31, 32, 33, 34]);
			}			
		}
		
		protected function onTimer2(event:TimerEvent):void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
		var layer:Layer_TableMain = NiuDirector.instance().getLayerInCurrentTopScene(Scene_Table.LAYER_MAIN) as Layer_TableMain;
			
			layer.showWaitGiveTimer(5);
		}
		*/
	}
}