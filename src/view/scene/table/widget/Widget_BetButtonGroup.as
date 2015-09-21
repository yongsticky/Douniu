package view.scene.table.widget
{
	import controller.NiuNotification;
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExSprite;
	
	public class Widget_BetButtonGroup extends ExSprite
	{
		public function Widget_BetButtonGroup(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			var btnRobNo:Button = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_no")));
			btnRobNo.x = 0;
			btnRobNo.y = 0;			
			btnRobNo.visible = false;
			addChild(btnRobNo);
			
			var btnRob1x:Button = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_1x")));
			btnRob1x.x = btnRobNo.x + btnRobNo.width - 10;
			btnRob1x.y = btnRobNo.y;
			btnRob1x.addEventListener(Event.TRIGGERED, onBtnRob1xTriggered);
			addChild(btnRob1x);
			
			var btnRob2x:Button = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_2x")));
			btnRob2x.x = btnRob1x.x + btnRob1x.width - 10;
			btnRob2x.y = btnRobNo.y;
			btnRob2x.addEventListener(Event.TRIGGERED, onBtnRob2xTriggered);
			addChild(btnRob2x);
			
			var btnRob4x:Button = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.ask_rob_4x")));
			btnRob4x.x = btnRob2x.x + btnRob2x.width - 10;
			btnRob4x.y = btnRobNo.y;
			btnRob4x.addEventListener(Event.TRIGGERED, onBtnRob4xTriggered);
			addChild(btnRob4x);				
		}
		
		private function onBtnRob1xTriggered(event:Event):void
		{
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_BET_X, 1);
		}
				
		private function onBtnRob2xTriggered(event:Event):void
		{
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_BET_X, 3);
		}
		
		private function onBtnRob4xTriggered(event:Event):void
		{			
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_BET_X, 5);
		}
	}
}