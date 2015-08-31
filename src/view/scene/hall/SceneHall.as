package view.scene.hall
{
	import view.framework.ExLayer;
	import view.framework.ExScene;
	import view.scene.hall.layer.LayerBackground;
	import view.scene.hall.layer.LayerContent;

	public final class SceneHall extends ExScene
	{		
		private var _layerBackground:ExLayer;		// 背景层
		private var _layerContent:ExLayer;			// 内容层
		//private var _layerAniEffect:ExLayer;		// 动画效果层
		
		public static const BACKGROUND:String = "hall.background";
		public static const CONTENT:String = "hall.content";

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
			_layerContent = new LayerContent();

			addLayer(BACKGROUND, _layerBackground);
			addLayer(CONTENT, _layerContent);
		}
	}

}