package resource
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import camu.design_pattern.Singleton;
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import resource.dev.HallSceneRes;
		

	public class ResManager extends EventDispatcher
	{
		private var _logger:ILogger;		
		
		private var _loaders:Vector.<Loader>;
		private var _res:Dictionary;

		private var _resHallScene:HallSceneRes;

		public static const ID:String = "id";						// 资源的id，存取的唯一标识
		public static const URL:String = "url";						// 资源的下载地址
		public static const TYPE:String = "type";					// 资源的类型，有image、movieclip、sound等
		public static const PACK_TYPE:String = "packType";			// 打包类型，有zip、swf、none
		public static const COMPLETE_HANDLER:String = "completeHandler";			// 完成通知
		public static const ERROR_HANDLER:String = "errorHandler";					// 错误通知
		public static const PROGRESS_HANDLER:String = "progressHandler";			// 进度通知

		
		private static const STATUS:String = "status";			// 0:未开始下载  1：正在下载  2：下载完成  3：下载失败
		private static const PROPS:String = "props";
		
		
		private static const S_INIT:int = 0;
		private static const S_RUNNING:int = 1;
		private static const S_COMPLETE:int = 2;
		private static const S_FAILED:int = 3;

		public function ResManager()
		{
			super();
			
			_logger = Logger.createLogger(ResManager, LEVEL.DEBUG);
			
			_res = new Dictionary();
			_loaders = new Vector.<Loader>();

			_resHallScene = new HallSceneRes();
		}
		
		
		public static function instance() : ResManager
		{
			return Singleton.instanceOf(ResManager);
		}

		public function registerResource(id:String, props:Object) : void
		{
			if (!_get(id))
			{
				var res:Object = {};
				res[ID] = id;
				res[STATUS] = S_INIT;
				res[PROPS] = props;

				_set(res);
			}
			else
			{
				throw new Error("resource already register.");
			}
		}

		public function loadResource(id:String) : void
		{
			var res:Object = _get(id);
			if (res)
			{
				if (res[STATUS] == S_INIT || res[STATUS] == S_FAILED)		// 未下载或者下载失败
				{
					_startLoadResource(res);
				}
			}
		}

		public function getResource(id:String) : *
		{
			return null;
		}

		public function getResourceDev(id:String) : *
		{
			return _resHallScene.getResource(id);
		}



		private function _get(id:String) : Object
		{
			if (_res.hasOwnProperty(id))
			{
				return _res[id];
			}
			else
			{
				return null;
			}
		}

		private function _set(res:Object) : void
		{
			_res[res[ID]] = res;
		}
				

		private function _startLoadResource(res:Object) : void
		{
			_logger.log("_startLoadResource Enter.", LEVEL.INFO);
			
			if (!res)
			{
				return;
			}	
			
			var loader:Loader = new Loader();		
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			
			
			_logger.log("_startLoadResource, URL=", res[PROPS][URL], LEVEL.INFO);
			
			res[STATUS] = S_RUNNING;
			loader.load(new URLRequest(res[PROPS][URL]));	
			
			
			_loaders.push(loader);
						
		}
		
		private function onComplete(event:Event) : void
		{
			_logger.log("onComplete Enter.", LEVEL.INFO);	
		}
		
		private function onIoError(event:IOErrorEvent) : void
		{
			_logger.log("onIoError Enter.", LEVEL.INFO);
		}
		
		private function onSecurityError(event:SecurityErrorEvent) : void
		{
			_logger.log("onSecurityError Enter.", LEVEL.INFO);
		}
		
		private function onProgress(event:ProgressEvent) : void
		{
			_logger.log("onProgress Enter.", LEVEL.INFO);
		}
	}
}