package resource
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class ResManager extends EventDispatcher
	{
		public static const Event_Complete:String = "complete";
		public static const Event_Failed:String = "failed";
		public static const Event_Progress:String = "progress";

		private var _dictResource:Dictionary = null;
		
		public function ResManager()
		{
			_dictResource = new Dictionary();
		}

		public function loadFromJson(text:String) : Boolean
		{
			var rootObj:Object = JSON.parse(text);
			if (!!rootObj)
			{
				for (var name:String in rootObj)
				{
					if (!!name)
					{
						var v:Object = {};
						v["complete"] = false;
						v["failed"] = false;
						v["running"] = false;
						v["loaderInfo"] = rootObj[name];					
						_dictResource[name] = v;
					}

				}
				
				return true;
			}

			return false;
		} 

		public function getResource(resId:String, sceneId:String) : *
		{
			return null;
		}

		public function loadSceneResources(sceneId:String) : void
		{
		}
		
		public function loadResource(resId:String, sceneId:String) : void
		{
		}
	}
}