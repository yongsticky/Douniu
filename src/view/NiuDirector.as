package view
{
	import camu.view.starling.ExDirector;
	
	public class NiuDirector extends ExDirector
	{
		public function NiuDirector()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var text:String = "{\"scene_1\":{\"preload\":1,\"server\":\"http://s1.res.download.camu.com\",\"loader\":[{\"path\":\"/hall.swf\",\"type\":\"swf\",\"weight\":12443},{\"path\":\"/room.swf\",\"type\":\"swf\",\"weight\":11576},{\"path\":\"/player.swf\",\"type\":\"swf\",\"weight\":11732}]},\"scene_2\":{\"preload\":0,\"server\":\"http://s1.res.download.camu.com\",\"loader\":[{\"path\":\"/poker.swf\",\"type\":\"swf\",\"weight\":23357},{\"path\":\"/timer.swf\",\"type\":\"swf\",\"weight\":74362},{\"path\":\"/button.swf\",\"type\":\"swf\",\"weight\":32417}]}}";
			
			var o:Object = JSON.parse(text);
			
			trace(o);
			
		}
	}
}