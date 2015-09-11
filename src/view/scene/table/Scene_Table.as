package view.scene.table
{
	import view.framework.ExScene;
	import view.scene.table.layer.Layer_Background;
	import view.scene.table.layer.Layer_BottomBanner;
	import view.scene.table.layer.Layer_Table;
	import view.scene.table.layer.Layer_TopBanner;
	
	public class Scene_Table extends ExScene
	{		
		private static const BACKGROUND:String = "table.background";
		private static const TOPBANNER:String = "table.topbanner";
		private static const BOTTOMBANNER:String = "table.bottombanner";
		private static const TABLE:String = "table.table";
		
		public function Scene_Table(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			addChild(new Layer_Background(BACKGROUND));
			addChild(new Layer_TopBanner(TOPBANNER));
			addChild(new Layer_BottomBanner(BOTTOMBANNER));
			addChild(new Layer_Table(TABLE));			
		}	
	}
}