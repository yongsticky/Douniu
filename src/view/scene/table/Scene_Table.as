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
		
		public function Scene_Table(id:String)
		{
			super(id);
		}
		
		override protected function createChildren() : void
		{
			addLayer(BACKGROUND, new Layer_Background());
			addLayer(TOPBANNER, new Layer_TopBanner());
			addLayer(BOTTOMBANNER, new Layer_BottomBanner());
			addLayer(TABLE, new Layer_Table());
		}	
	}
}