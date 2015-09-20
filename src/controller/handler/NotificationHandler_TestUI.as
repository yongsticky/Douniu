package controller.handler
{
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_GameTable;
	
	public class NotificationHandler_TestUI extends NiuNotificationHandler
	{
		private var _first:Boolean = true;
		
		public function NotificationHandler_TestUI(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			var scene:Scene_Table = new Scene_Table();
			NiuDirector.instance().switchToScene(scene);
			
			
			
			var layer:Layer_GameTable = scene.getChildByNameWithRecursive("table.table");
			
			layer.showPlayer("3000011", 10000, 0);
			layer.showOtherPlayer("3000012", 12000, 1);
			layer.showTimer(3);
			
			var timer:Timer = new Timer(3000, 2);
			timer.addEventListener(TimerEvent.TIMER, OnTimer);			
			timer.start();
		}
		
		protected function OnTimer(event:TimerEvent):void
		{
			var scene:Scene_Table = NiuDirector.instance().topScene as Scene_Table;
			var layer:Layer_GameTable = scene.getChildByNameWithRecursive("table.table");
	

			if (_first)
			{
				layer.hideTimer();
				layer.showPlayerCards(new <int>[1, 2, 3, 4, 5]);
				layer.showOtherPlayerCards(new <int>[0, 0, 0, 0, 0]);
				
				_first = false;
			}
			else
			{
				layer.showPlayerCards(new <int>[21, 32, 33, 34, 0]);
				layer.showOtherPlayerCards(new <int>[30, 31, 32, 33, 34]);
			}			
		}
	}
}