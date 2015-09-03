package view.scene.mall
{
	import view.framework.ExLayer;
	import view.framework.ExScene;
	
	import view.scene.mall.layer.Layer_Background;
	
	
	public class Scene_Mall extends ExScene
	{
		private var _layerBackground:ExLayer;
		
		public function Scene_Mall()
		{
			super("mall");
		}
	
		override protected function createChildren() : void 
		{
			_layerBackground = new Layer_Background();	
			
			addLayer("scene.setting.bkg", _layerBackground);
		}
	}
}