package resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
		

	public class ResManager extends EventDispatcher
	{
		protected var _logger:ILogger;	
		
		private var _jsonRootObj:Object = null;		
		private var _res:Dictionary;		

		public function ResManager(inner:PrivateInner)
		{
			super();
			
			_logger = Logger.createLogger(ResManager, LEVEL.DEBUG);
			
			_res = new Dictionary();							
		}
		
		
		private static var _instance:ResManager = null;
		public static function instance() : ResManager
		{
			if (!_instance)
			{
				_instance = new ResManager(new PrivateInner());
			}
			
			return _instance;
		}

		public function loadResources() : void
		{
			var loader:BulkLoader = new BulkLoader("config_loader");			
			loader.add("http://app.camu.com/game/douniu/resource/res.json", {"id":"preload", "preventCache":true});
			loader.addEventListener(BulkProgressEvent.COMPLETE, onConfigFileLoadComplete);			
			
			loader.start();			
		}		
		
		protected function onConfigFileLoadComplete(event:BulkProgressEvent):void
		{
			_logger.log(this, "onConfigFileLoadComplete.", LEVEL.INFO);
			(event.target as BulkLoader).removeEventListener(BulkProgressEvent.COMPLETE, onConfigFileLoadComplete);			
			
			var jsonStr:String = (event.target as BulkLoader).getText("preload");
			_jsonRootObj = JSON.parse(jsonStr);
			if (_jsonRootObj)
			{
				var loader:BulkLoader = new BulkLoader("res_loader");
				loader.addEventListener(BulkProgressEvent.PROGRESS, onResLoadProgress);
				loader.addEventListener(BulkProgressEvent.COMPLETE, onResLoadComplete);
				
				var server:String = _jsonRootObj["preload"]["server"];
				for each(var item:Object in _jsonRootObj["preload"]["res_list"])
				{
					var url:String = server+item["path"];					
					var loadingItem:LoadingItem = loader.add(server+item["path"], {"id":item["id"], "weight":item["weight"], "preventCache":true});
					loadingItem.addEventListener(BulkProgressEvent.COMPLETE, onResItemComplete);
					
					_logger.log(this, "add item: url:",url, LEVEL.INFO);
				}				
				
				loader.start();
			}
		}
		
		protected function onResItemComplete(event:Event):void
		{			
			var item:LoadingItem = event.target as LoadingItem; 
			item.removeEventListener(BulkProgressEvent.COMPLETE, onResItemComplete);
			
			
			if (item.type == BulkLoader.TYPE_MOVIECLIP)
			{				
				var clsArr:Array = null;
				for (var i:int in _jsonRootObj["preload"]["res_list"])
				{
					if (_jsonRootObj["preload"]["res_list"][i]["id"] == item.id)
					{
						clsArr = _jsonRootObj["preload"]["res_list"][i]["classes"];
						break;
					}
				}
								
				
				for each(var clsName:String in clsArr)
				{
					var cls:Class = Object(item).loader.contentLoaderInfo.applicationDomain.getDefinition(clsName);
					
					var resId:String = item.id + "." + clsName;					
					_res[resId] = new cls();					
					
					if (_res[resId] is Bitmap)
					{						
						_logger.log(this, "add res: id[", resId, "], clsName[", clsName, "], classType[Bitmap].",  LEVEL.INFO);
					}
					else if (_res[resId] is BitmapData)
					{
						_logger.log(this, "add res: id[", resId, "], clsName[", clsName, "], classType[BitmapData].",  LEVEL.INFO);
					}
					else if (_res[resId] is Sound)
					{
						_logger.log(this, "add res: id[", resId, "], clsName[", clsName, "], classType[Sound].",  LEVEL.INFO);
					}
					else
					{
						_logger.log(this, "add res: id[", resId, "], clsName[", clsName, "], classType[Unknown].",  LEVEL.INFO);
					}
				}				
			}			
		}
		
		protected function onResLoadProgress(event:BulkProgressEvent):void
		{
			dispatchEvent(event);
		}
		
		protected function onResLoadComplete(event:BulkProgressEvent):void
		{
			(event.target as BulkLoader).removeEventListener(BulkProgressEvent.PROGRESS, onResLoadProgress);
			(event.target as BulkLoader).removeEventListener(BulkProgressEvent.COMPLETE, onResLoadComplete);
			
			dispatchEvent(event);		
		}
		
		public function getResource(id:String) : *
		{
			if (_res.hasOwnProperty(id))
			{
				return _res[id];
			}
			else
			{
				throw new Error("No Found Resource["+id+"]");
			}
		}	
	}
}

class PrivateInner
{

}