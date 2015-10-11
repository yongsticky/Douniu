package view.scene.table.layer
{
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;
	import view.scene.setting.Scene_Setting;
	
	public class Layer_TopBanner extends ExLayer
	{
		private var _bg:ExImage;
		private var _title:TextField;
		private var _broadcast:TextField;
		private var _setting:Button;
		
		public function Layer_TopBanner(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResourceDev("table.top_banner"));
			_bg.x = _bg.y = 0;
			addChild(_bg);
			
			_title = new TextField(100, 24, "欢乐牛牛", "", 14, 0xF19940);
			_title.hAlign = "left";
			_title.x = 10;
			_title.y = (_bg.height - 24) >> 1;
			addChild(_title);
			
			_broadcast = new TextField(300, 24, "恭喜好友【Lisa】在牛牛比赛中打出金牛！", "", 14, 0xFFFFFF);
			_broadcast.hAlign = "left";
			_broadcast.x = (_bg.width - _broadcast.width) >> 1;
			_broadcast.y = (_bg.height - _broadcast.height) >> 1;
			addChild(_broadcast);
			
			_setting = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.setting")), "");
			_setting.x = _bg.width - _setting.width - 10;
			_setting.y = (_bg.height - _setting.height) >> 1;
			addChild(_setting);
			_setting.addEventListener(Event.TRIGGERED, onTrigered);
		}	
		
		private function onTrigered(event:Event) : void
		{
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.USER_LOGOUT);
		}
	}
}