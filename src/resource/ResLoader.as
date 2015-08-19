package resource
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import camu.loader.ILoaderEventHandler;
	import camu.loader.LoaderTask;
	import camu.loader.MultiLoader;


	public class ResLoader extends EventDispatcher implements ILoaderEventHandler
	{		
		private var _dictSceneResources:Dictionary = null;		
		
		public function ResLoader()
		{
			_dictSceneResources = new Dictionary();
		}

		public function loadFromJson(text:String) : Boolean
		{
			var rootObj:Object = JSON.parse(text);
			if (!!rootObj)
			{
				for (var sceneId:String in rootObj)
				{
					_dictSceneResources[sceneId] = new ResInfo(sceneId, rootObj[sceneId]);
				}
			}
			
			return false;
		}

		public function getUniqueResource(sceneId:String, resId:String) : *
		{
			if (_dictSceneResources.hasOwnProperty(sceneId))
			{
				var resInfo:ResInfo = _dictSceneResources[sceneId];
				if (!!resInfo)
				{
					if (resInfo.isComplete())
					{
						var task:LoaderTask = resInfo.getUniqueLoaderTask(resId);
						if (!!task)
						{
							return task.content;
						}							
					}
				}
			}

			return null;
		}

		public function loadSceneResources(sceneId:String) : void
		{
			if (_dictSceneResources.hasOwnProperty(sceneId))
			{
				var resInfo:ResInfo = _dictSceneResources[sceneId];
				if (!!resInfo)
				{
					if (resInfo.isComplete())
					{
						dispatchEvent(new ResLoaderEvent(ResLoaderEvent.COMPLETE));
						return;
					}
					else if (resInfo.isRunning())
					{
						return;
					}
					
					var loader:MultiLoader = new MultiLoader(resInfo.sceneId, resInfo.loaderTasks, this);
					loader.start();					
				}
			}
		}
		
		public function loadUniqueResource(sceneId:String, resId:String) : void
		{
			
		}
		
		public function onProgress(event:Event) : void
		{
			var loader:MultiLoader = event.target as MultiLoader;
			if (!!loader)
			{
				if (_dictSceneResources.hasOwnProperty(loader.name))
				{
					var resInfo:ResInfo = _dictSceneResources[loader.name];
					
					resInfo.updateProgress();
				}				
			}				
		}
		
		public function onComplete(event:Event) : void
		{
			var loader:MultiLoader = event.target as MultiLoader;
			if (!!loader)
			{
				if (_dictSceneResources.hasOwnProperty(loader.name))
				{
					var resInfo:ResInfo = _dictSceneResources[loader.name];
					
					resInfo.updateComplete();
				}				
			}				
		}
		
		public function onError(event:Event) : void
		{
			var loader:MultiLoader = event.target as MultiLoader;
			if (!!loader)
			{
				if (_dictSceneResources.hasOwnProperty(loader.name))
				{
					var resInfo:ResInfo = _dictSceneResources[loader.name];
					
					resInfo.updateFailed();
				}				
			}				
		}
	}
}
