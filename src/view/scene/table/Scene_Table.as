package view.scene.table
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.table.layer.Layer_TableBottom;
	import view.scene.table.layer.Layer_TableMain;
	import view.scene.table.layer.Layer_TableMask;
	import view.scene.table.layer.Layer_TableTop;
	
	public class Scene_Table extends ExScene
	{	
		public static const LAYER_MAIN:String = "layer.table.main"; 
		public static const LAYER_TOP:String = "layer.table.top";
		
		private var _bg:ExImage;
		private var _mask:Layer_TableMask;
		
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
			
			addChild(new Layer_TableTop(LAYER_TOP));
			addChild(new Layer_TableBottom());
			
			_tableMain = new Layer_TableMain(LAYER_MAIN); 
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