package view.scene.table.cell
{
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExSprite;
	
	public class ReadyButtonGroup extends ExSprite
	{
		private var _quit:Button;
		private var _another:Button;
		private var _continue:Button;
		
		
		public function ReadyButtonGroup(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_quit = new Button(Texture.fromBitmapData(resManager.getResource("ui.button_bg_orange")), "离开");			
			_quit.fontBold = true;
			_quit.fontColor = 0xFFFFFF;
			_quit.fontSize = 16;
			_quit.fontName = "Microsoft YaHei";
			_quit.addEventListener(Event.TRIGGERED, onQuit);
			addChild(_quit);
			
			_another = new Button(Texture.fromBitmapData(resManager.getResource("ui.button_bg_blue")), "换桌");
			_another.x = _quit.x + _quit.width + 10;
			_another.fontBold = true;
			_another.fontColor = 0xFFFFFF;
			_another.fontSize = 16;
			_another.fontName = "Microsoft YaHei";
			_another.addEventListener(Event.TRIGGERED, onAnother);
			addChild(_another);
			
			_continue = new Button(Texture.fromBitmapData(resManager.getResource("ui.button_bg_blue")), "继续");
			_continue.x = _another.x + _another.width + 10;
			_continue.fontBold = true;
			_continue.fontColor = 0xFFFFFF;
			_continue.fontSize = 16;
			_continue.fontName = "Microsoft YaHei";
			_continue.addEventListener(Event.TRIGGERED, onContinue);
			addChild(_continue);			
		}
		
		private function onQuit(event:Event):void
		{			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.USER_LOGOUT);	
		}
		
		private function onAnother(event:Event):void
		{			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.ANOTHER_DESK);
		}
		
		private function onContinue(event:Event):void
		{			
			visible = false;	
		}
	}
}