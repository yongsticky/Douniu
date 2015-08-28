package view.scene.hall.layer
{
	import starling.display.Image;
	
	import view.framework.ExLayer;

	public class LayerBackground extends ExLayer
	{
		
		private var _bkgImg:Image;
		
		public function LayerBackground()
		{
			super();
		}
		
		override protected function initialize() : void
		{
			super.initialize();
			
			createAllChildren();			
		}
		
		
		private function createAllChildren() : void
		{
			
		}
	}
}