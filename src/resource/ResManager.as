package resource
{
	import flash.utils.Dictionary;
	import flash.events.EventDispatcher;

	public class ResManager extends EventDispatcher
	{
		public static const Event_Complete:String = "complete";
		public static const Event_Failed:String = "failed";
		public static const Event_Progress:String = "progress";

		private var _dictRes:Dictionary = new Dictionary();
		
		public function ResManager()
		{
		}

		public function initResLoaderInfo(data:String) : Boolean
		{		
			return false;
		} 

		public function getResource(resId:String, sceneId:String) : *
		{
			return null;
		}

		public function loadSceneResources(sceneId:String) : void
		{

		}
	}
}