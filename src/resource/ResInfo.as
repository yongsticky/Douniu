package resource
{
	import camu.loader.LoaderTask;

	public class ResInfo
	{
		private var _sceneId:String = null;
		private var _loaderTasks:Vector.<LoaderTask> = null;
		
		private var _loaderStatus:int = -1;
		
		
		public static const StRunning:int = 1;
		public static const StComplete:int = 2;
		public static const StFailed:int = 3;
		
		public function ResInfo(sceneId:String, obj:Object)
		{
			if (!!obj)
			{				
				_loaderTasks = new Vector.<LoaderTask>();
			}

			_sceneId = sceneId;
		}

		public function get sceneId() : String
		{
			return _sceneId;
		}
		
		public function get loaderTasks() : Vector.<LoaderTask>
		{
			return _loaderTasks;
		}
		
		public function getUniqueLoaderTask(resId:String) : LoaderTask
		{
			var task:LoaderTask = null;
			_loaderTasks.some(
				function (item:LoaderTask, index:int, ar:Vector.<LoaderTask>) : Boolean
				{
					if (item.id == resId)
					{
						task = item;
						return true;
					}
					else
					{
						return false;
					}
				}
			);

			return task;
		}
		
		public function isRunning() : Boolean
		{
			return (_loaderStatus == StRunning);
		}
		
		public function isComplete() : Boolean
		{
			return (_loaderStatus == StComplete);
		}
		
		public function isFailed() : Boolean
		{
			return (_loaderStatus == StFailed);
		}
		
		public function updateProgress() : void
		{
			_loaderStatus = StRunning;
		}
		
		public function updateComplete() : void
		{
			_loaderStatus = StComplete;
		}
		
		public function updateFailed() : void
		{
			_loaderStatus = StFailed;
		}
	}
}