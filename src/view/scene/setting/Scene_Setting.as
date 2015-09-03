package view.scene.setting
{
	import view.framework.ExLayer;
	import view.framework.ExScene;
	import view.scene.setting.layer.Layer_Background;
	
	
	public class Scene_Setting extends ExScene
	{
		private var _layerBackground:ExLayer;
		
		public function Scene_Setting()
		{
			super("setting");
		}
	
		override protected function createChildren() : void 
		{
			_layerBackground = new Layer_Background();	
			
			addLayer("scene.setting.bkg", _layerBackground);
		}
	}
}