package resource
{		
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	public class ResLoader extends EventDispatcher
	{		
		private var _dictSceneResources:Dictionary = null;		
		
		public function ResLoader()
		{
			_dictSceneResources = new Dictionary();
		}

		public function loadFromJson(text:String) : void
		{
			var rootObj:Object = JSON.parse(text);
			if (!!rootObj)
			{
				for (var sceneId:String in rootObj)
				{
					var task:BulkLoaderTask = new BulkLoaderTask(sceneId);
					task.loadTaskData(rootObj[sceneId]);
					
					var taskLoader:BulkLoader = task.loader;
					
					taskLoader.addEventListener(BulkLoader.COMPLETE, onComplete);
					taskLoader.addEventListener(BulkLoader.PROGRESS, onProgress);
					taskLoader.addEventListener(BulkLoader.ERROR, onError);
					
					
					_dictSceneResources[sceneId] = task;
					
				}
				
				preloadResource();
			}	
		}	
		
		protected function onComplete(event:BulkProgressEvent):void
		{
			var taskLoader:BulkLoader = event.target as BulkLoader;
			if (!!taskLoader)
			{
				taskLoader.removeEventListener(BulkLoader.COMPLETE, onComplete);			
				taskLoader.removeEventListener(BulkLoader.PROGRESS, onProgress);
				taskLoader.removeEventListener(BulkLoader.ERROR, onError);
			}
			
			dispatchEvent(new ResLoaderEvent(event.type));
		}
		
		protected function onProgress(event:BulkProgressEvent):void
		{			
			dispatchEvent(new ResLoaderEvent(event.type));
		}
		
		protected function onError(event:BulkProgressEvent):void
		{			
			dispatchEvent(new ResLoaderEvent(event.type));
		}
		
		public function getResource(sceneId:String, resId:String) : *
		{
			if (_dictSceneResources.hasOwnProperty(sceneId))
			{
				var task:BulkLoaderTask = _dictSceneResources[sceneId];
				if (!!task && task.loaderStatus == BulkLoaderTask.LS_RAN)
				{
					var loader:BulkLoader = task.loader;
					if (!!loader)
					{
						return loader.getContent(resId);
					}
				}
				
			}

			return null;
		}

		public function loadeResources(sceneId:String) : void
		{
			if (_dictSceneResources.hasOwnProperty(sceneId))
			{
				var task:BulkLoaderTask = _dictSceneResources[sceneId];
				if (!!task && task.loaderStatus == ResInfo.LS_READY)
				{
					task.loader.start();
				}
			}
		}
		
		protected function preloadResource() : void
		{
			for each(var task:BulkLoaderTask in _dictSceneResources)
			{
				if (task.preload)
				{
					task.loader.start();
				}
			}
		}
		
	}
}
