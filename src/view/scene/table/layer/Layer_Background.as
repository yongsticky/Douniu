package view.scene.table.layer
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExLayer;
	
	public class Layer_Background extends ExLayer
	{
		private var _bg:ExImage;	
		private var _logo:ExImage;
		
		public function Layer_Background(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResourceDev("table.bg"));
			addChild(_bg);
			
			
			_logo = new ExImage(resManager.getResourceDev("table.bg_logo"));
			_logo.x = (stage.stageWidth - _logo.width) >> 1;
			_logo.y = (stage.stageHeight - _logo.height) >> 1;
			_logo.alpha = 0.1;
			addChild(_logo);
			
		}

		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}