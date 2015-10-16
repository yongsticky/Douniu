package view.scene.loading
{
	import view.framework.ExScene;
	import view.scene.loading.layer.Layer_Background;
	import view.scene.loading.layer.Layer_Loading;
	
	public class Scene_Loading extends ExScene
	{
		public function Scene_Loading(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			addChild(new Layer_Background());
			addChild(new Layer_Loading("loading"));
		}
	}
}