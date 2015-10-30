package view.scene.hall.layer
{			
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;
	import view.scene.hall.widget.Widget_PlayerInfo;
	import view.scene.mall.Scene_Mall;
	import view.scene.setting.Scene_Setting;
	
	
	public class Layer_Top extends ExLayer
	{
		private var _bg:ExImage;		
		private var _playerInfo:Widget_PlayerInfo;
		private var _setting:Button;
		private var _mall:Button;		
		private var _notice_bg:ExImage;		
		
		public function Layer_Top(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResource("ui.hall_top_bg"));
			addChild(_bg);
			
			
			_playerInfo = new Widget_PlayerInfo();
			_playerInfo.x = 10;
			_playerInfo.y = 8;
			addChild(_playerInfo);
			
			_notice_bg = new ExImage(resManager.getResource("ui.notice_bg"));			
			_notice_bg.y = 18;
			addChild(_notice_bg);
					
			_setting = new Button(Texture.fromBitmapData(resManager.getResource("ui.round_button_setting_in_hall")));
			_setting.y = 17;
			addChild(_setting);
			
			_mall = new Button(Texture.fromBitmapData(resManager.getResource("ui.round_button_vip_mall_in_hall")));
			_mall.y = 80;
			addChild(_mall);			
		}
		
		override protected function layoutChildren():void
		{
			_bg.width = stage.stageWidth;			
			_notice_bg.x = (stage.stageWidth - 392)/2;
			_setting.x = stage.stageWidth - _setting.width - 20;			
			_mall.x = stage.stageWidth - _mall.width - 24;
			
		}
				
		protected function onSettingTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().pushScene(new Scene_Setting());			
		}
		
		protected function onVipMallTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().pushScene(new Scene_Mall());
		}
	}
}