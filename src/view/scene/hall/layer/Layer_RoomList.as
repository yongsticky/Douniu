package view.scene.hall.layer
{	
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.events.Event;
	
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
			
			_classicRoomTitle = new ExImage(resManager.getResource("hall.type2_room.png"));
			_classicRoomTitle.x = (stage.stageWidth - _classicRoomTitle.width)/2 - 20;
			_classicRoomTitle.y = 200;
			addChild(_classicRoomTitle);
			
			_viewRoomTitle = new ExImage(resManager.getResource("hall.type1_room.png"));
			_viewRoomTitle.x = (stage.stageWidth - _classicRoomTitle.width)/2 - 20;
			_viewRoomTitle.y = 560;
			addChild(_viewRoomTitle);
			
			
			var xStart:int = 120;			
			for (var i:int = 0; i < MAX_ROOM_NUM_PER_TYPE; i++)
			{
				var classicRoom:Widget_Room = new Widget_Room();
				classicRoom.roomName = "经典房";
				classicRoom.roomDesc = ((i+1)*100).toString() + "金币可进入";
				classicRoom.roomId = 76;
				classicRoom.x = xStart;
				classicRoom.y = 260;			
				classicRoom.addEventListener(Event.TRIGGERED, onRoomTriggered);
				addChild(classicRoom);
				
				var viewRoom:Widget_Room = new Widget_Room();			
				viewRoom.roomName = "看牌房";
				viewRoom.roomDesc = ((i+1)*500).toString() + "金币可进入";
				viewRoom.roomId = 81;
				viewRoom.x = xStart;
				viewRoom.y = 400;				
				viewRoom.addEventListener(Event.TRIGGERED, onRoomTriggered);
				addChild(viewRoom);
				
				var huanleRoom:Widget_Room = new Widget_Room();			
				huanleRoom.roomName = "欢乐房";
				huanleRoom.roomDesc = ((i+1)*10).toString() + "欢乐券可进入";
				huanleRoom.roomId = 84;
				huanleRoom.x = xStart;
				huanleRoom.y = 620;				
				huanleRoom.addEventListener(Event.TRIGGERED, onRoomTriggered);
				addChild(huanleRoom);				
				
				xStart += classicRoom.width + 40;
			}			
		}		

		protected function onRoomTriggered(event:Event) : void
		{
			SoundManager.instance().playButtonClick();
			
			var room:Widget_Room = event.target as Widget_Room;				
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_ROOM, room.roomId);			
		}
	}
}