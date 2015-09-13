package view.scene.hall.layer
{	
	import controller.NiuHandlerConstant;
	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;	
	
	public class Layer_RoomList extends ExLayer
	{
		private var _room1Icon:ExImage;
		private var _room1List:Vector.<Button>;
		
		private var _room2Icon:ExImage;
		private var _room2List:Vector.<Button>;
		
		private static const MAX_ROOM_NUM_PER_TYPE:int = 4;
		
		public function Layer_RoomList(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_room1Icon = new ExImage(resManager.getResourceDev("hall.type1_room"));
			_room1Icon.x = (stage.stageWidth - _room1Icon.width)/2 - 20;
			_room1Icon.y = 200;
			addChild(_room1Icon);
			
			_room2Icon = new ExImage(resManager.getResourceDev("hall.type2_room"));
			_room2Icon.x = (stage.stageWidth - _room1Icon.width)/2 - 20;
			_room2Icon.y = 400;
			addChild(_room2Icon);
			
			var buttonBGTexture:Texture = Texture.fromBitmapData(resManager.getResourceDev("hall.room_bg"));
			
			_room1List = new Vector.<Button>();
			_room2List = new Vector.<Button>();

			var xStart:int = 120;			
			for (var i:int = 0; i < MAX_ROOM_NUM_PER_TYPE; i++)
			{
				var btn1:Button = new Button(buttonBGTexture);
				btn1.x = xStart;
				btn1.y = 260;				
				
				var roomNameText:TextField = new TextField(100, 24, "练习场", "", 20, 0);
				roomNameText.x = 15;
				roomNameText.y = 10;
				btn1.addChild(roomNameText);
				btn1.name = "3000000" + (i+1).toString();
				addChild(btn1);
				_room1List.push(btn1);				
				btn1.addEventListener(Event.TRIGGERED, onRoomTriggered);				
				
				
				var btn2:Button = new Button(buttonBGTexture);
				btn2.x = xStart;
				btn2.y = 460;
				
				addChild(btn2);
				_room2List.push(btn2);
				btn2.addEventListener(Event.TRIGGERED, onRoomTriggered);
				
				xStart += btn1.width + 40;
			}
		}		

		private function onRoomTriggered(event:Event) : void
		{			
			var rid:int = 76;
			var r:Button = event.target as Button;
			
			NiuDirector.instance().sendNotification(NiuHandlerConstant.ENTER_ROOM, {"rid":rid, "uin":r.name});					
		}
	}
}