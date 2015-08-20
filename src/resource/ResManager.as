package resource
{
	import flash.utils.Dictionary;
	
	import camu.loader.IResourceHolder;
	import camu.loader.ResourceLoader;
	import camu.loader.ResourceLoaderEvent;

	public class ResManager implements IResourceHolder
	{
		private var _container:Dictionary = null;
		private var _sceneStates:Dictionary = null;		
		private var _loadedScenes:Vector.<String> = null;
		private var _loader:ResourceLoader = null;
		
		public function ResManager()
		{		
			_container = new Dictionary();
			_loadedScenes = new Vector.<String>();
			
			_loader = new ResourceLoader(this);
			
			_loader.addEventListener(ResourceLoaderEvent.SCENE_COMPLETE, onSecneComplete);
		}
		
		protected function onSecneComplete(event:ResourceLoaderEvent):void
		{
			var sceneId:String = event.theId;
			if (_loadedScenes.indexOf(sceneId) == -1)
			{
				_loadedScenes.push(sceneId);
			}
		}
		
		public function push(itemId:String, item:*) : void
		{
			if (itemId && item)
			{
				_container[itemId] = item;				
			}
		}
		
		public function initialize() : void
		{
			// sample
			var text:String = "{\"scene_1\":{\"preload\":1,\"server\":\"http://s1.res.download.camu.com\",\"loader\":[{\"path\":\"/hall.swf\",\"type\":\"swf\",\"weight\":12443},{\"path\":\"/room.swf\",\"type\":\"swf\",\"weight\":11576},{\"path\":\"/player.swf\",\"type\":\"swf\",\"weight\":11732}]},\"scene_2\":{\"preload\":0,\"server\":\"http://s1.res.download.camu.com\",\"loader\":[{\"path\":\"/poker.swf\",\"type\":\"swf\",\"weight\":23357},{\"path\":\"/timer.swf\",\"type\":\"swf\",\"weight\":74362},{\"path\":\"/button.swf\",\"type\":\"swf\",\"weight\":32417}]}}";
			_loader.loadFromJson(text);
		}
		
		public function loadResources(sceneId:String) : void
		{
			if (_loadedScenes.indexOf(sceneId) != -1)
			{
				_loader.loadeResources(sceneId);
			}
		}
		
		public function getResource(sceneId:String, resId:String) : *
		{
			if (sceneId && resId)
			{
				var key:String = combineKey(sceneId, resId);
				
				if (_container.hasOwnProperty(key))
				{
					return _container[key];
				}
			}

			return null;
		}
		
		protected function combineKey(sceneId:String, resId:String) : String
		{
			return (sceneId + "." + resId);
		}
	}
}