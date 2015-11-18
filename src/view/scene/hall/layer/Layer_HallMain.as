package view.scene.hall.layer
{	
	import starling.events.Event;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;
	import view.scene.hall.cell.RoomItem;
	import facade.NiuNotificationHandlerConstant;
	import resource.ResManager;
	import sound.SoundManager;
	
	public class Layer_HallMain extends ExLayer
	{			
		private var _douniuRoomTitle:ExImage;		
		private var _huanleRoomTitle:ExImage;
		
		
		private static const MAX_ROOM_NUM_PER_TYPE:int = 3;
		
		public function Layer_HallMain(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_douniuRoomTitle = new ExImage(resManager.getResource("ui.room_type_text_douniu"));			
			addChild(_douniuRoomTitle);
			
			_huanleRoomTitle = new ExImage(resManager.getResource("ui.room_type_text_huanle"));			
			addChild(_huanleRoomTitle);
			
			var xStart:int = 0;
			for (var i:int = 0; i < MAX_ROOM_NUM_PER_TYPE; i++)
			{
				var cr:RoomItem = new RoomItem(resManager.getResource("ui.room_icon_basic"));
				cr.roomDescTextFontFace = "Microsoft YaHei";
				cr.roomDescTextFontSize = 12;
				cr.roomDescTextFontColor = 0xFDBC2A;
				cr.roomDesc = ((i+1)*100).toString() + "金币可进入";
				cr.roomId = 76;								
				cr.x = xStart;
				cr.y = 40;
				addChild(cr);				
				cr.addEventListener(Event.TRIGGERED, onRoomTriggered);
				
				
				var ar:RoomItem = new RoomItem(resManager.getResource("ui.room_icon_advance"));
				ar.roomDescTextFontFace = "Microsoft YaHei";
				ar.roomDescTextFontSize = 12;
				ar.roomDescTextFontColor = 0xFDBC2A;
				ar.roomDesc = ((i+1)*500).toString() + "金币可进入";
				ar.roomId = 81;			
				ar.x = xStart;
				ar.y = 180;
				addChild(ar);				
				ar.addEventListener(Event.TRIGGERED, onRoomTriggered);
				
				
				var hr:RoomItem = new RoomItem(resManager.getResource("ui.room_icon_betting"));
				hr.roomDescTextFontFace = "Microsoft YaHei";
				hr.roomDescTextFontSize = 12;
				hr.roomDescTextFontColor = 0xFDBC2A;
				hr.roomDesc = ((i+1)*10).toString() + "欢乐券可进入";
				hr.roomId = 84;								
				hr.x = xStart;
				hr.y = 400;
				addChild(hr);				
				hr.addEventListener(Event.TRIGGERED, onRoomTriggered);
				
				
				xStart += 320;
			}				
			
			_douniuRoomTitle.x = (width - _douniuRoomTitle.width)/2;
			_douniuRoomTitle.y = 0;
			
			_huanleRoomTitle.x = _douniuRoomTitle.x; 
			_huanleRoomTitle.y = 360;			
		}		

		protected function onRoomTriggered(event:Event) : void
		{
			SoundManager.instance().playButtonClick();
			
			var room:RoomItem = event.target as RoomItem;				
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.ENTER_ROOM, room.roomId);			
		}
	}
}