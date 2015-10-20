package view.scene.hall
{	
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.hall.layer.Layer_RoomList;
	import view.scene.hall.layer.Layer_TopBanner;
	

	public final class Scene_Hall extends ExScene
	{			
		public static const BACKGROUND:String = "hall.background";			// 背景层
		public static const BANNER:String = "hall.topbanner";				// 顶部栏
		public static const ROOMLIST:String = "hall.roomlist";				// 房间列表
		
		private var _bg:ExImage;
		private var _topBanner:ExImage;
				
		public function Scene_Hall(name:String = null)
		{
			super(name);
		}

		override protected function createChildren() : void 
		{
			var resManager:ResManager = ResManager.instance();			
			
			_bg = new ExImage(resManager.getResource("hall.bg.png"));			
			addChild(_bg);					
			
			_topBanner = new ExImage(resManager.getResource("hall.top_banner.png"));
			addChild(_topBanner);
			
			addChild(new Layer_TopBanner());
			addChild(new Layer_RoomList());			
		}
		
		override protected function layoutChildren() : void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
			
			_topBanner.width = stage.stageWidth;
			
			super.layoutChildren();
		}
	}
}