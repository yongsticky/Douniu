package view.scene.hall.layer
{	
	
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExLayer;

	public class LayerBackground extends ExLayer
	{				
		private var _bg:ExImage;
		private var _banner:ExImage;
		
		public function LayerBackground()
		{
			super();
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResourceDev("hall.bg"));
			_banner = new ExImage(resManager.getResourceDev("hall.banner"));
			
			addChild(_bg);
			addChild(_banner);
		}
	}
}