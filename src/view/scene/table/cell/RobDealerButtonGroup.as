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
		private var _btnRob1x:Button;
		private var _btnRob2x:Button;
		private var _btnRob3x:Button;
		
		public function RobDealerButtonGroup(name:String = null)
		{
			super(name);
		}		
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			var btnRobNo:Button = new Button(resManager.getResource("ui.button_bg_blue"));			
			btnRobNo.addEventListener(Event.TRIGGERED, onBtnRobNoTriggered);
			btnRobNo.fontBold = true;
			btnRobNo.fontSize = 16;
			btnRobNo.fontColor = 0xFFFFFF;
			btnRobNo.text = "不抢庄";
			btnRobNo.fontName = "Microsoft YaHei";
			addChild(btnRobNo);
			
			var tBg:Texture = resManager.getResource("ui.button_bg_orange");
			
			
			_btnRob1x = new Button(tBg);
			_btnRob1x.x = btnRobNo.x + btnRobNo.width;
			_btnRob1x.y = btnRobNo.y;
			_btnRob1x.fontBold = true;
			_btnRob1x.fontSize = 16;
			_btnRob1x.fontColor = 0xFFFFFF;
			_btnRob1x.fontName = "Microsoft YaHei";
			_btnRob1x.addEventListener(Event.TRIGGERED, onBtnRob1xTriggered);
			addChild(_btnRob1x);
			
			_btnRob2x = new Button(tBg);
			_btnRob2x.x = _btnRob1x.x + _btnRob1x.width;
			_btnRob2x.y = btnRobNo.y;
			_btnRob2x.fontBold = true;
			_btnRob2x.fontSize = 16;
			_btnRob2x.fontColor = 0xFFFFFF;
			_btnRob2x.fontName = "Microsoft YaHei";
			_btnRob2x.addEventListener(Event.TRIGGERED, onBtnRob2xTriggered);
			addChild(_btnRob2x);
			
			_btnRob3x = new Button(tBg);
			_btnRob3x.x = _btnRob2x.x + _btnRob2x.width;
			_btnRob3x.y = btnRobNo.y;
			_btnRob3x.fontBold = true;
			_btnRob3x.fontSize = 16;
			_btnRob3x.fontColor = 0xFFFFFF;
			_btnRob3x.fontName = "Microsoft YaHei";
			_btnRob3x.addEventListener(Event.TRIGGERED, onBtnRob3xTriggered);
			addChild(_btnRob3x);			
		}	
		
		public function updateMultiple(x1:int, x2:int, x3:int) : void
		{
			if(x1)
			{
				_btnRob1x.text = x1.toString() + "倍抢";				
			}
			
			if(x2)
			{
				_btnRob2x.text = x2.toString() + "倍抢";
			}
			
			if(x3)
			{
				_btnRob3x.text = x3.toString() + "倍抢";
			}
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
		
		private function onBtnRob3xTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			visible = false;
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_ROB_DEALER_X, 5);
		}
		

	}
}