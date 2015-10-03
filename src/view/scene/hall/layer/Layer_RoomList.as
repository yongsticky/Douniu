package view.scene.hall.layer
{	
	import starling.events.Event;

	import facade.NiuNotificationHandlerConstant;	
	import resource.ResManager;
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;
	import view.scene.hall.widget.Widget_Room;
	
	public class Layer_RoomList extends ExLayer
	{
		private var _classicRoomTitle:ExImage;		
		private var _viewRoomTitle:ExImage;

		
		private static const MAX_ROOM_NUM_PER_TYPE:int = 4;
		
		public function Layer_RoomList(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_classicRoomTitle = new ExImage(resManager.getResourceDev("hall.type1_room"));
			_classicRoomTitle.x = (stage.stageWidth - _classicRoomTitle.width)/2 - 20;
			_classicRoomTitle.y = 200;
			addChild(_classicRoomTitle);
			
			_viewRoomTitle = new ExImage(resManager.getResourceDev("hall.type2_room"));
			_viewRoomTitle.x = (stage.stageWidth - _classicRoomTitle.width)/2 - 20;
			_viewRoomTitle.y = 400;
			addChild(_viewRoomTitle);

			var xStart:int = 120;			
			for (var i:int = 0; i < MAX_ROOM_NUM_PER_TYPE; i++)
			{
				var classicRoom:Widget_Room = new Widget_Room();
				classicRoom.roomName = "经典场";
				classicRoom.roomDesc = ((i+1)*100).toString() + "金币可进入";
				classicRoom.roomId = 76;
				classicRoom.x = xStart;
				classicRoom.y = 260;			
				classicRoom.addEventListener(Event.TRIGGERED, onRoomTriggered);
				addChild(classicRoom);
				
				var viewRoom:Widget_Room = new Widget_Room();			
				viewRoom.roomName = "看牌场";
				viewRoom.roomDesc = ((i+1)*500).toString() + "金币可进入";
				viewRoom.roomId = 81;
				viewRoom.x = xStart;
				viewRoom.y = 460;				
				viewRoom.addEventListener(Event.TRIGGERED, onRoomTriggered);
				addChild(viewRoom);
				
				xStart += classicRoom.width + 40;
			}
		}		

		protected function onRoomTriggered(event:Event) : void
		{
			var room:Widget_Room = event.target as Widget_Room;				
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_ROOM, room.roomId);
		}
	}
}