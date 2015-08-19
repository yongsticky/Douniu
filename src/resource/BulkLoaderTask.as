package resource
{
	import br.com.stimuli.loading.BulkLoader;
	
	public class BulkLoaderTask
	{
		private var _sceneId:String = null;		
		private var _loader:BulkLoader = null;
		
		private var _preload:Boolean = false;
		private var _server:String = null;
		
		
		public static const LS_READY:int = 0;
		public static const LS_RAN:int = 1;
		
		private var _loaderStatus:int = LS_READY;
		
		
		public function BulkLoaderTask(sceneId:String)
		{
			_sceneId = sceneId;
			_loader = new BulkLoader(sceneId);
		}
		
		public function loadTaskData(obj:Object) : void
		{
			if (!!obj)
			{
				_preload = obj["preload"];
				_server = obj["server"];
				
				var items:Array = obj["loaders"];
				for each(var item:Object in items)
				{					
					_loader.add(_server + item["path"], item);
				}				
			}
		}
		
		public function get sceneId() : String
		{
			return _sceneId;
		}
		
		public function get loader() : BulkLoader
		{
			return _loader;
		}
		
		public function get preload() : Boolean
		{
			return _preload;
		}
		
		public function get loaderStatus() : int
		{
			return _loaderStatus;
		}
		
	}
}