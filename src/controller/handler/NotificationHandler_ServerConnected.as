package controller.handler
{	
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	
	import resource.ResManager;
	
	import view.NiuDirector;
	import view.scene.loading.Scene_Loading;
	import view.scene.loading.layer.Layer_LoadingMain;
	import view.scene.selectuser.Scene_SelectUser;
	
	import facade.NiuNotificationHandlerConstant;
	
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
			
			
			//sendNotification(NiuNotificationHandlerConstant.TEST_UI);
			
			NiuDirector.instance().switchToScene(new Scene_SelectUser());
		}
		
		protected function onProgress(event:BulkProgressEvent):void
		{			
			var scene:Scene_Loading = NiuDirector.instance().topScene as Scene_Loading;
			if (scene)
			{
				var layer:Layer_LoadingMain = scene.getChildByName("loading") as Layer_LoadingMain;
				if (layer)
				{				
					layer.updatePercent(event._weightPercent*100);
				}
			}
			
		}		
		
	}
}