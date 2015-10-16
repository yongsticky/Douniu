package view.scene.loading.layer
{
	import starling.display.Quad;
	
	import view.framework.ExLayer;
	
	public class Layer_Background extends ExLayer
	{
		public function Layer_Background(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var qd:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x222222);			
			addChild(qd);
		}
	}
}