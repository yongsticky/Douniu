package view.scene.hall
{
	import view.framework.ExLayer;
	import view.framework.ExScene;
	import view.scene.hall.layer.LayerBackground;
	import view.scene.hall.layer.LayerBanner;
	import view.scene.hall.layer.LayerRoomList;

	public final class SceneHall extends ExScene
	{		
		private var _layerBackground:ExLayer;		// 背景层
		private var _layerBanner:ExLayer;			// 内容层
		private var _layerRoomList:ExLayer;
		//private var _layerAniEffect:ExLayer;		// 动画效果层
		
		public static const BACKGROUND:String = "hall.background";
		public static const BANNER:String = "hall.banner";
		public static const ROOMLIST:String = "hall.roomlist"
		
		public function SceneHall()
		{
			super("hall");			
		}

		override protected function initialize() : void
		{
			super.initialize();			
		} 


		override protected function createChildren() : void 
		{
			_layerBackground = new LayerBackground();
			_layerBanner = new LayerBanner();
			_layerRoomList = new LayerRoomList();

			addLayer(BACKGROUND, _layerBackground);
			addLayer(BANNER, _layerBanner);
			addLayer(ROOMLIST, _layerRoomList);
		}
	}

}