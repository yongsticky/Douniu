package view.scene.hall
{	
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.hall.layer.Layer_RoomList;
	import view.scene.hall.layer.Layer_Top;
	

	public final class Scene_Hall extends ExScene
	{			
		private var _bg:ExImage;
		private var _rooms:Layer_RoomList;
				
		public function Scene_Hall(name:String = null)
		{
			super(name);
		}

		override protected function createChildren() : void 
		{
			var resManager:ResManager = ResManager.instance();			
			
			_bg = new ExImage(resManager.getResource("ui.hall_bg"));			
			addChild(_bg);					
								
			addChild(new Layer_Top());
			_rooms = new Layer_RoomList();
			addChild(_rooms);
		}
		
		override protected function layoutChildren() : void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;			
			
			_rooms.x = (stage.stageWidth-_rooms.width)/2 + 16;
			_rooms.y = 120;
			
			super.layoutChildren();
		}
	}
}