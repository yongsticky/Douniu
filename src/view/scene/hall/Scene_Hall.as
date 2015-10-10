package view.scene.hall
{	
	import view.framework.ExScene;
	import view.scene.hall.layer.Layer_Background;
	import view.scene.hall.layer.Layer_RoomList;
	import view.scene.hall.layer.Layer_TopBanner;

	public final class Scene_Hall extends ExScene
	{			
		public static const BACKGROUND:String = "hall.background";			// 背景层
		public static const BANNER:String = "hall.topbanner";				// 顶部栏
		public static const ROOMLIST:String = "hall.roomlist"				// 房间列表 
		
		public function Scene_Hall(name:String = null)
		{
			super(name);
		}

		override protected function createChildren() : void 
		{
			addChild(new Layer_Background());
			addChild(new Layer_TopBanner());
			addChild(new Layer_RoomList());			
		}		
	}
}