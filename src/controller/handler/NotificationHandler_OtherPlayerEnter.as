package controller.handler
{
	
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;
	
	import controller.NiuNotificationHandler;
	
	import view.NiuDirector;
	import view.scene.table.Scene_Table;
	import view.scene.table.layer.Layer_GameTable;
	
	public class NotificationHandler_OtherPlayerEnter extends NiuNotificationHandler implements INotificationHandler
	{
		private var _count:int = 0;
		public function NotificationHandler_OtherPlayerEnter(mediator:Mediator)
		{
			super(mediator);
		}
		
		public function execute(notification:Notification):void
		{
			var t:Timer = new Timer(1500);
			t.addEventListener(TimerEvent.TIMER, onTimer);
			t.start();
		}
		
		protected function onTimer(event:TimerEvent) : void
		{			 
			var sceneTable:Scene_Table = NiuDirector.instance().getNamedChildByName("scene.table") as Scene_Table;
			if (sceneTable)
			{
				var layerTable:Layer_GameTable = sceneTable.getNamedChildByName("table.table") as Layer_GameTable;
				if (layerTable)
				{
					
					layerTable.showOtherPlayer(_count);					
				}
			}
			
			if (_count == 4)
			{				
				var t:Timer = event.target as Timer;
				
				t.removeEventListener(TimerEvent.TIMER, onTimer);
				
				t.stop();			
			}
			
			_count ++;
		}
	}
}