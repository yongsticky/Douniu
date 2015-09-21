package view.scene.table
{
	import view.framework.ExScene;
	import view.scene.table.layer.Layer_Background;
	import view.scene.table.layer.Layer_BottomBanner;
	import view.scene.table.layer.Layer_TableMain;
	import view.scene.table.layer.Layer_TopBanner;
	
	public class Scene_Table extends ExScene
	{		
		private static const BACKGROUND:String = "table.background";
		private static const TOPBANNER:String = "table.topbanner";
		private static const BOTTOMBANNER:String = "table.bottombanner";
		private static const TABLEMAIN:String = "table.main";
		
		public function Scene_Table(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			addChild(new Layer_Background(BACKGROUND));
			addChild(new Layer_TopBanner(TOPBANNER));
			addChild(new Layer_BottomBanner(BOTTOMBANNER));
			addChild(new Layer_TableMain(TABLEMAIN));			
		}	
	}
}