package view.scene.huanle.layer
{	
	import douniu.NiuSuggest;
	
	import facade.NiuNotificationHandlerConstant;
	
	import packet.game.tv.value.FinishInfo;
	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.events.Event;
	
	import view.NiuDirector;
	import view.framework.ExLayer;
	import view.scene.huanle.cell.Robot;
	import view.widget.Widget_Timer;
	
	public class Layer_HuanleMain extends ExLayer
	{
		private var _dealer:Robot;		
		private var _robots:Vector.<Robot>;
		private var _timer:Widget_Timer;
		
		private var _continue:Button;
		
		private var _selectedSeatId:int;
		
		public function Layer_HuanleMain(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			_dealer = new Robot(4);
			_dealer.sepWidth = 60;
			addChild(_dealer);
			_dealer.betButton.visible = false;
			
			_robots = new Vector.<Robot>(4);
			for (var i:int = 0; i < 4; ++i)
			{
				_robots[i] = new Robot(i);	
				_robots[i].addEventListener(Event.TRIGGERED, onBet);
				addChild(_robots[i]);
			}	
			
			_timer = new Widget_Timer();
			_timer.visible = false;
			addChild(_timer);
			
			_continue = new Button(ResManager.instance().getResource("ui.button_bg_blue"), "继续");
			_continue.fontBold = true;
			_continue.fontColor = 0xFFFFFF;
			_continue.fontSize = 16;
			_continue.fontName = "Microsoft YaHei";
			_continue.addEventListener(Event.TRIGGERED, onConinue);
			_continue.visible = false;
			addChild(_continue);
		}
		
		override protected function layoutChildren():void
		{
			_dealer.x = (stage.stageWidth - _dealer.width)>>1;
			_dealer.y = 100;				
			
			var w:int = (stage.stageWidth - 152*4)/5;			
			var startX:int = w;
			for (var i:int = 0; i < 4; ++i)
			{
				_robots[i].x = startX;
				_robots[i].y = stage.stageHeight - 300;
				
				startX += _robots[i].width + w;
			}
			
			_timer.x = (stage.stageWidth-_timer.width)>>1;
			_timer.y = -160 + (stage.stageHeight-_timer.height)>>1;
			
			_continue.x = _timer.x;
			_continue.y = _timer.y;
			
			super.layoutChildren();
		}	
		
		private function onConinue(event:Event):void
		{
			reset();
			
			event.stopImmediatePropagation();
		}
		
		private function onBet(event:Event) : void
		{			
			var robot:Robot =  event.currentTarget as Robot;
			if (robot)
			{
				_selectedSeatId = robot.seatId;								
			}
			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.HUANLE_BET);
			
			event.stopImmediatePropagation();
		}
		
		
		
		public function showTimer(time:int) : void
		{				
			_timer.startTimer(time);
		}
		
		public function hideTimer(): void
		{
			_timer.stopTimer();	
		}	
		
		public function hideBetButton() : void
		{
			for (var i:int = 0; i < 4; ++i)
			{
				_robots[i].betButton.visible = false;
			}
		}
		
		
		public function updatePokers(v:vector.<FinishInfo>) : void
		{	
			var seatIndex:int = 0;
			for each(var info:FinishInfo in v)
			{
				if (info)
				{															
					if (info.seat_id == 4)
					{						
						_dealer.setPokers(info.tiles);
						_dealer.showNiuResult(NiuSuggest.getSuggestObject(info.tiles)["niuType"]);
					}
					else if (info.seat_id == 0)
					{
						_robots[_selectedSeatId].setPokers(info.tiles);
						_robots[_selectedSeatId].showNiuResult(NiuSuggest.getSuggestObject(info.tiles)["niuType"]);
						_robots[_selectedSeatId].showResult(info.money.highPart, info.money.lowPart);
					}
					else
					{
						if (seatIndex == _selectedSeatId)
						{
							++ seatIndex;
						}
						
						_robots[seatIndex].setPokers(info.tiles);
						_robots[seatIndex].showNiuResult(NiuSuggest.getSuggestObject(info.tiles)["niuType"]);
						_robots[seatIndex].showResult(info.money.highPart, info.money.lowPart);
						
						++seatIndex;
					}					
				}
			}
		}
		
		public function startNewGame() : void
		{
			juggler.delayCall(showContinue, 3);				
		}
		
		private function showContinue() : void
		{
			_continue.visible = true;			
		}
		
		public function reset() : void
		{	
			_dealer.setPokers(null);
			_dealer.hideNiuResult();
						
			for (var i:int = 0; i < 4; ++i)
			{				
				_robots[i].setPokers(null);
				_robots[i].betButton.visible = true;
				_robots[i].hideNiuResult();
				_robots[i].hideResult();
			}
			
			_continue.visible = false;
		}
	}
}