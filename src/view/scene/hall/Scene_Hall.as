package view.scene.hall
{	
	import view.framework.ExScene;
	import view.scene.hall.layer.Layer_Background;
	import view.scene.hall.layer.Layer_TopBanner;
	import view.scene.hall.layer.Layer_RoomList;

	public final class Scene_Hall extends ExScene
	{			
		public static const BACKGROUND:String = "hall.background";			// 背景层
		public static const BANNER:String = "hall.topbanner";				// 顶部栏
		public static const ROOMLIST:String = "hall.roomlist"				// 房间列表 
		
		public function Scene_Hall()
		{
			super("hall");			
		}

		override protected function createChildren() : void 
		{
			addLayer(BACKGROUND, new Layer_Background());
			addLayer(BANNER, new Layer_TopBanner());
			addLayer(ROOMLIST, new Layer_RoomList());
		}		
	}

}