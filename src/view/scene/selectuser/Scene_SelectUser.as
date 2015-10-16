package view.scene.selectuser
{
	import view.framework.ExScene;
	import view.scene.selectuser.layer.Layer_Background;
	import view.scene.selectuser.layer.Layer_User;
	
	public class Scene_SelectUser extends ExScene
	{
		public function Scene_SelectUser(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			addChild(new Layer_Background());
			addChild(new Layer_User());
		}
	}
}