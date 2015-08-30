package resource
{	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import camu.design_pattern.Singleton;
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
		
		public static function instance() : ResManager
		{
			return Singleton.instanceOf(ResManager);
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
			var f:URLLoader = new URLLoader();
			f.addEventListener(Event.COMPLETE, onJsonLoadComplete);
			
			f.load(new URLRequest("../resource/res.json"));
		}
		
		protected function onJsonLoadComplete(event:Event):void
		{			
			var loader:URLLoader = event.target as URLLoader;
			if (loader.dataFormat == "text")
			{
				_loader.loadFromJson(loader.data as String);
			}			
			
			loader.removeEventListener(Event.COMPLETE, onJsonLoadComplete);
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