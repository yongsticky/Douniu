package view.scene.selectuser
{
	import starling.display.Quad;
	
	import view.framework.ExScene;	
	import view.scene.selectuser.layer.Layer_User;
	
	public class Scene_SelectUser extends ExScene
	{
		public function Scene_SelectUser(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var qd:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x222222);			
			addChild(qd);
			
			addChild(new Layer_User());
		}
	}
}