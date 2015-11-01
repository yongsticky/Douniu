package view.scene.mall
{	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.mall.layer.Layer_Mall;
	
	public class Scene_Mall extends ExScene
	{
		private var _bg:ExImage;
		private var _close:Button;
		
		public function Scene_Mall(name:String = null)
		{
			super(name);
		}
	
		override protected function createChildren() : void 
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResource("ui.mall_bg"));
			addChild(_bg);
			
			_close = new Button(Texture.fromBitmapData(resManager.getResource("ui.button_close")));
			_close.addEventListener(Event.TRIGGERED, onClose);
			addChild(_close);
			
			
			addChild(new Layer_Mall());		
		}
		
		override protected function layoutChildren():void
		{
			x = (stage.stageWidth - width) / 2;
			y = (stage.stageHeight - height) / 2;
			
			_close.x = width - _close.width - 20;
			_close.y = 20;
		}
		
		private function onClose(event:Event):void
		{			
			NiuDirector.instance().popScene().dispose();
		}
	}
}