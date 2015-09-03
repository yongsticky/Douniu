package view.scene.mall.layer
{
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;

	public class Layer_Background extends ExLayer
	{
		private var _bg:ExImage;
		
		public function Layer_Background()
		{
			super();
		}
		
		override protected function createChildren() : void
		{
			var texture:Texture = Texture.fromColor(600, 400, 0xFFFF0000);
			_bg = new ExImage(texture);
			_bg.x = (stage.stageWidth - _bg.width) >> 1;
			_bg.y = (stage.stageHeight - _bg.height ) >> 1;
			
			
			addChild(_bg);
			
			_bg.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
		
		private function onTouch(event:TouchEvent) : void
		{
			var touch:Touch = event.getTouch(_bg);
			if (touch)
			{
				if (touch.phase == TouchPhase.ENDED)
				{
					NiuDirector.instance().popScene().dispose();
				}
			}			
		}
	}
}