package view.scene.table.widget
{
	import starling.textures.Texture;	
	import starling.display.Button;
	import starling.events.Event;
	
	import resource.ResManager;
	import view.framework.ExSprite;

	public class Widget_RobButtonGroup extends ExSprite
	{	
		private var _btnRobNo:Button;
		private var _btnRob1x:Button;
		private var _btnRob2x:Button;
		private var _btnRob4x:Button;
		
		public function Widget_RobButtonGroup()
		{
			super();
		}
		
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_btnRobNo = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_no")));
			_btnRobNo.addEventListener(Event.TRIGGERED, onBtnRobNoTriggered);
			addChild(_btnRobNo);
			
			_btnRob1x = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_1x")));
			_btnRobNo.addEventListener(Event.TRIGGERED, onBtnRob1xTriggered);
			addChild(_btnRob1x);
			
			_btnRob2x = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_2x_disable")));
			_btnRob2x.enabled = false;
			_btnRobNo.addEventListener(Event.TRIGGERED, onBtnRob2xTriggered);
			addChild(_btnRob2x);
			
			_btnRob4x = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_4x_disable")));
			_btnRob4x.enabled = false;
			_btnRobNo.addEventListener(Event.TRIGGERED, onBtnRob4xTriggered);
			addChild(_btnRob4x);
			
		}
		
		override protected function layoutChildren() : void
		{
			super.layoutChildren();
			
			_btnRobNo.x = 0;
			_btnRobNo.y = 0;
			
			_btnRob1x.x = _btnRobNo.x + _btnRobNo.width - 10;
			_btnRob1x.y = _btnRobNo.y;
			
			_btnRob2x.x = _btnRob1x.x + _btnRob1x.width - 10;
			_btnRob2x.y = _btnRobNo.y;
			
			_btnRob4x.x = _btnRob2x.x + _btnRob2x.width - 10;
			_btnRob4x.y = _btnRobNo.y;
			
		}
		
		private function onBtnRobNoTriggered(event:Event) : void
		{			
			
		}
		
		private function onBtnRob1xTriggered(event:Event) : void
		{			
			
		}
		
		private function onBtnRob2xTriggered(event:Event) : void
		{			
			
		}
		
		private function onBtnRob4xTriggered(event:Event) : void
		{			
			
		}
		

	}
}