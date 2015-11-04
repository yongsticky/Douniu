package view.scene.setting
{	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExScene;
	import resource.ResManager;
	
	
	public class Scene_Setting extends ExScene
	{	
		private var _bg:ExImage;
		private var _close:Button;
		
		public function Scene_Setting(name:String = null)
		{
			super(name);
		}
	
		override protected function createChildren() : void 
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResource("ui.setting_bg"));
			addChild(_bg);
			
			_close = new Button(resManager.getResource("ui.button_close"));
			_close.addEventListener(Event.TRIGGERED, onClose);
			addChild(_close);
		}
		
		override protected function layoutChildren():void
		{
			x = (stage.stageWidth - width) / 2;
			y = (stage.stageHeight - height) / 2;
			
			_close.x = width - _close.width - 20;
			_close.y = 20;
		}
		
		private function onClose(event:Event) : void
		{
			NiuDirector.instance().popScene().dispose();
		}
	}
}