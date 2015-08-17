package resource
{
	import camu.loader.LoaderTask;

	public class ResLoaderInfo
	{
		private _loaderTask:LoaderTask;

		private var _loading:Boolean = false;
		private var _complete:Boolean = false;
		private var _failed:Boolean = false;
		
		public function ResLoaderInfo()
		{			
		}		

		public function get loading() : Boolean
		{
			return _loading;
		}

		public function get complete() : Boolean
		{
			return _complete;
		}

		public function get failed() : Boolean
		{
			return _failed;
		}

		public function get loaderTask() : LoaderTask
		{
			return _loaderTask;
		}
	}
}