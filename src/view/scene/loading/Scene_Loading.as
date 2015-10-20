package view.scene.loading
{
	import starling.display.Quad;
	
	import view.framework.ExScene;	
	import view.scene.loading.layer.Layer_Loading;
	
	public class Scene_Loading extends ExScene
	{
		public function Scene_Loading(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			var qd:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x222222);			
			addChild(qd);
			
			
			addChild(new Layer_Loading("loading"));
		}
	}
}