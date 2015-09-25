package view.scene.table.widget
{
	import facade.NiuNotificationHandlerConstant;
	
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
		
		public function Widget_BetButtonGroup(name:String=null)
		{
			super(name);
		}
		
		public function setBetMultiple(x1:int, x2:int, x3:int) : void
		{
			if (_firstBet)
			{
				_firstBet.text = x1.toString() + " 倍";
				_secondBet.text = x2.toString() + " 倍";
				_thirdBet.text = x3.toString() + " 倍";
			}
		}
		
		override protected function createChildren() : void
		{			
			_firstBet = new Button(Texture.fromColor(100, 48, 0xFF0000FF), "");
			_firstBet.x = 60;
			_firstBet.addEventListener(Event.TRIGGERED, onBtnRob1xTriggered);
			addChild(_firstBet);
			
			_secondBet = new Button(Texture.fromColor(100, 48, 0xFF0000FF), "");
			_secondBet.x = _firstBet.x + _firstBet.width + 5;
			_secondBet.addEventListener(Event.TRIGGERED, onBtnRob2xTriggered);
			addChild(_secondBet);
			
			_thirdBet = new Button(Texture.fromColor(100, 48, 0xFF0000FF), "");
			_thirdBet.x = _secondBet.x + _secondBet.width + 5;
			_thirdBet.addEventListener(Event.TRIGGERED, onBtnRob4xTriggered);
			addChild(_thirdBet);				
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