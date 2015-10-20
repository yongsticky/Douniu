package view.scene.table
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.table.layer.Layer_BottomBanner;
	import view.scene.table.layer.Layer_TableMain;
	import view.scene.table.layer.Layer_TopBanner;
	
	public class Scene_Table extends ExScene
	{		
		private static const BACKGROUND:String = "table.background";
		private static const TOPBANNER:String = "table.topbanner";
		private static const BOTTOMBANNER:String = "table.bottombanner";
		private static const TABLEMAIN:String = "table.main";
		
		protected var _bg:ExImage;
		
		public function Scene_Table(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();			
		
			_bg = new ExImage(resManager.getResource("table.bg.png"));
			addChild(_bg);
			
			var logo:ExImage = new ExImage(resManager.getResource("table.bg_logo.png"));
			logo.x = (stage.stageWidth - logo.width) >> 1;
			logo.y = (stage.stageHeight - logo.height) >> 1;
			logo.alpha = 0.1;
			addChild(logo);
			
			
			addChild(new Layer_TopBanner(TOPBANNER));
			addChild(new Layer_BottomBanner(BOTTOMBANNER));
			addChild(new Layer_TableMain(TABLEMAIN));			
		}
		
		override protected function layoutChildren() : void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
			
			super.layoutChildren();
		}
	}
}