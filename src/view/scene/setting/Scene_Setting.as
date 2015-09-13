package view.scene.setting
{	
	import view.framework.ExScene;
	import view.scene.setting.layer.Layer_Background;
	
	
	public class Scene_Setting extends ExScene
	{		
		public function Scene_Setting(name:String = null)
		{
			super(name);
		}
	
		override protected function createChildren() : void 
		{
			addChild(new Layer_Background());			
		}
	}
}