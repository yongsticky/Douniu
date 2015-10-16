package controller.handler
{		
	import flash.events.Event;
	
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import resource.ResManager;
	
	import view.NiuDirector;
	import view.scene.loading.Scene_Loading;
	import view.scene.loading.layer.Layer_Loading;
	import view.scene.selectuser.Scene_SelectUser;
	
	public class NotificationHandler_ServerConnected extends NiuNotificationHandler
	{
		public function NotificationHandler_ServerConnected(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			NiuDirector.instance().switchToScene(new Scene_Loading());
					
			var resManager:ResManager = ResManager.instance();
			
			resManager.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			resManager.addEventListener(BulkProgressEvent.COMPLETE, onComplete);
			
			resManager.loadResources();
			
			
		}
		
		protected function onComplete(event:BulkProgressEvent):void
		{
			_logger.log(this, "onComplete", LEVEL.INFO);
			
			NiuDirector.instance().switchToScene(new Scene_SelectUser());
		}
		
		protected function onProgress(event:BulkProgressEvent):void
		{			
			var scene:Scene_Loading = NiuDirector.instance().topScene as Scene_Loading;
			if (scene)
			{
				var layer:Layer_Loading = scene.getChildByNameWithRecursive("loading");
				if (layer)
				{				
					layer.updatePercent(event._weightPercent*100);
				}
			}
			
		}		
		
	}
}