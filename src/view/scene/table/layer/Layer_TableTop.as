package view.scene.table.layer
{
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;
	import view.scene.setting.Scene_Setting;
	
	public class Layer_TableTop extends ExLayer
	{
		private var _bg:ExImage;
				
		private var _setting:Button;
		
		public function Layer_TableTop(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
									
			_bg = new ExImage(Texture.fromColor(1, 40, 0x64000000));
			_bg.x = _bg.y = 0;
			addChild(_bg);
			
			_setting = new Button(resManager.getResource("ui.setting"));
			_setting.y = 4;
			addChild(_setting);
			_setting.addEventListener(Event.TRIGGERED, onSetting);
			
		}
		
		override protected function layoutChildren():void
		{
			_bg.width = stage.stageWidth;
			
			_setting.x = _bg.width - _setting.width - 10;
			
			super.layoutChildren();
		}
		
		private function onSetting(event:Event) : void
		{
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().pushScene(new Scene_Setting());
		}
	}
}