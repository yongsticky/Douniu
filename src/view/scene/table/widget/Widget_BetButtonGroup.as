package view.scene.table.widget
{
	import facade.NiuNotificationHandlerConstant;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExSprite;
	
	public class Widget_BetButtonGroup extends ExSprite
	{
		private var _firstBet:Button;
		private var _secondBet:Button;
		private var _thirdBet:Button;

		private var _multiples:Array = new Array();
		
		public function Widget_BetButtonGroup(name:String=null)
		{
			super(name);
		}
		
		public function setBetMultiple(x1:int, x2:int, x3:int) : void
		{
			if (_firstBet)
			{
				_firstBet.text = x1.toString() + " 倍";
				_multiples[0] = x1;
				_secondBet.text = x2.toString() + " 倍";
				_multiples[1] = x2;
				_thirdBet.text = x3.toString() + " 倍";
				_multiples[2] = x3;
			}
		}
		
		override protected function createChildren() : void
		{			
			_firstBet = new Button(Texture.fromColor(100, 48, 0xFF0000FF), "");
			_firstBet.name = "0";
			_firstBet.x = 60;
			_firstBet.addEventListener(Event.TRIGGERED, onBtnRobTriggered);
			addChild(_firstBet);
			
			_secondBet = new Button(Texture.fromColor(100, 48, 0xFF0000FF), "");
			_secondBet.name = "1";
			_secondBet.x = _firstBet.x + _firstBet.width + 5;
			_secondBet.addEventListener(Event.TRIGGERED, onBtnRobTriggered);
			addChild(_secondBet);
			
			_thirdBet = new Button(Texture.fromColor(100, 48, 0xFF0000FF), "");
			_thirdBet.name = "2";
			_thirdBet.x = _secondBet.x + _secondBet.width + 5;
			_thirdBet.addEventListener(Event.TRIGGERED, onBtnRobTriggered);
			addChild(_thirdBet);				
		}
		
		private function onBtnRobTriggered(event:Event):void
		{
			visible = false;

			SoundManager.instance().playButtonClick();		
			
			var btn:Button = event.target as Button;
			var multiple:int = _multiples[int(btn.name)];				

			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_BET_X, multiple);	
		}		
	}
}