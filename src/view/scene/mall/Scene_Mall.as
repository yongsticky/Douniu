package view.scene.mall
{
	import view.framework.ExLayer;
	import view.framework.ExScene;
	import view.scene.mall.layer.Layer_Background;
	
	
	public class Scene_Mall extends ExScene
	{
		private var _layerBackground:ExLayer;
		
		public function Scene_Mall(name:String = null)
		{
			super(name);
		}
	
		override protected function createChildren() : void 
		{
			addChild(new Layer_Background());			
		}
	}
}