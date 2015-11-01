package view.scene.table.cell
{
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExSprite;

	public class RobDealerButtonGroup extends ExSprite
	{		
		public function RobDealerButtonGroup(name:String = null)
		{
			super(name);
		}
		
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			var btnRobNo:Button = new Button(Texture.fromBitmapData(resManager.getResource("ui.button_bg_blue")));
			btnRobNo.x = 0;
			btnRobNo.y = 0;
			btnRobNo.addEventListener(Event.TRIGGERED, onBtnRobNoTriggered);			
			addChild(btnRobNo);
			
			var tBg:Texture = Texture.fromBitmapData(resManager.getResource("ui.button_bg_orange"));
			var btnRob1x:Button = new Button(tBg);
			btnRob1x.x = btnRobNo.x + btnRobNo.width;
			btnRob1x.y = btnRobNo.y;
			btnRob1x.addEventListener(Event.TRIGGERED, onBtnRob1xTriggered);
			addChild(btnRob1x);
			
			var btnRob2x:Button = new Button(tBg);
			btnRob2x.x = btnRob1x.x + btnRob1x.width;
			btnRob2x.y = btnRobNo.y;
			btnRob2x.addEventListener(Event.TRIGGERED, onBtnRob2xTriggered);
			addChild(btnRob2x);
			
			var btnRob4x:Button = new Button(tBg);
			btnRob4x.x = btnRob2x.x + btnRob2x.width;
			btnRob4x.y = btnRobNo.y;
			btnRob4x.addEventListener(Event.TRIGGERED, onBtnRob4xTriggered);
			addChild(btnRob4x);			
		}		

		
		private function onBtnRobNoTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_ROB_DEALER_X, 0);
		}
		
		private function onBtnRob1xTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_ROB_DEALER_X, 1);
		}
		
		private function onBtnRob2xTriggered(event:Event) : void
		{
			SoundManager.instance().playButtonClick();
			
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_ROB_DEALER_X, 3);
		}
		
		private function onBtnRob4xTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_ROB_DEALER_X, 5);
		}
		

	}
}