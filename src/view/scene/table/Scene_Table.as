package view.scene.table
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.table.layer.Layer_Bottom;
	import view.scene.table.layer.Layer_TableMain;
	import view.scene.table.layer.Layer_TopBanner;
	
	public class Scene_Table extends ExScene
	{		
		protected var _bg:ExImage;
		
		private var _tableMain:Layer_TableMain;
		
		public function Scene_Table(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();			
		
			_bg = new ExImage(resManager.getResource("ui.table_bg"));
			addChild(_bg);
			
			addChild(new Layer_TopBanner());
			addChild(new Layer_Bottom());
			
			_tableMain = new Layer_TableMain("table.main"); 
			addChild(_tableMain);			
		}
		
		override protected function layoutChildren() : void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
			
			
			super.layoutChildren();
		}
	}
}