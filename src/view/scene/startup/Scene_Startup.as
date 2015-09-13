package view.scene.startup
{
	import view.framework.ExScene;
	import view.scene.startup.layer.Layer_Background;
	import view.scene.startup.layer.Layer_Loading;
	
	public class Scene_Startup extends ExScene
	{
		public function Scene_Startup(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			addChild(new Layer_Background());
			addChild(new Layer_Loading());
		}
	}
}