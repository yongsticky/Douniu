package view.scene.setting.layer
{
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
		
	import view.NiuDirector;	
	import view.framework.ExLayer;

	public class Layer_Background extends ExLayer
	{		
		public function Layer_Background(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{		
			var qd:Quad = new Quad(600, 400, 0x0000FF);
			qd.x = (stage.stageWidth - qd.width) >> 1;
			qd.y = (stage.stageHeight - qd.height) >> 1;
			addChild(qd);
									
			qd.addEventListener(TouchEvent.TOUCH, onTouch);
		}
				
		private function onTouch(event:TouchEvent) : void
		{
			var touch:Touch = event.getTouch(event.target as Quad);
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