package view.scene.huanle.layer
{
	import flash.net.sendToURL;
	
	import facade.NiuNotificationHandlerConstant;
	
	import packet.game.tv.value.FinishInfo;
	
	import starling.display.Button;
	import starling.events.Event;
	
	import view.NiuDirector;
	import view.framework.ExLayer;
	import view.scene.huanle.widget.Widget_Robot;
	import view.widget.Widget_Timer;
	
	public class Layer_Main extends ExLayer
	{
		private var _dealer:Widget_Robot;		
		private var _players:Vector.<Widget_Robot>;
		private var _timer:Widget_Timer;
		
		public function Layer_Main(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			_dealer = new Widget_Robot(4);
			_dealer.sepWidth = 70;
			addChild(_dealer);
			_dealer.betButton.visible = false;
			
			_players = new Vector.<Widget_Robot>(4);
			for (var i:int = 0; i < 4; ++i)
			{
				_players[i] = new Widget_Robot(i);	
				_players[i].addEventListener(Event.TRIGGERED, onTriggered);
				addChild(_players[i]);
			}	
			
			_timer = new Widget_Timer();
			_timer.visible = false;
			addChild(_timer);
		}
		
		private function onTriggered(event:Event) : void
		{			
			var robot:Widget_Robot =  event.target["parent"] as Widget_Robot;
			if (robot)
			{
				var oldSeatId:int = robot.seatId;
				if (oldSeatId != 0)
				{
					
					
					for each(var r:Widget_Robot in _players)
					{
						if (r.seatId == 0)
						{
							r.seatId = oldSeatId;
						}
					}					
						
					robot.seatId = 0;
				}				
			}
			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.HUANLE_BET);
			
			event.stopImmediatePropagation();
		}
		
		override protected function layoutChildren():void
		{
			_dealer.x = (stage.stageWidth - _dealer.width)>>1;
			_dealer.y = 100;				
			
			var w:int = (stage.stageWidth - 152*4)/5;			
			var startX:int = w;
			for (var i:int = 0; i < 4; ++i)
			{
				_players[i].x = startX;
				_players[i].y = stage.stageHeight - 300;
				
				startX += _players[i].width + w;
			}
			
			_timer.x = (stage.stageWidth-_timer.width)>>1;
			_timer.y = -160 + (stage.stageHeight-_timer.height)>>1;
			
			super.layoutChildren();
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
				_players[i].betButton.visible = false;
			}
		}
		
		
		public function updatePokers(v:vector.<FinishInfo>) : void
		{			
			for each(var info:FinishInfo in v)
			{
				if (info)
				{
					var vec:Vector.<int> = new Vector.<int>(5);
					for (var i:int = 0; i < 5; ++i)
					{
						vec[i] = int(info.tiles[i]);	
					}
					
					if (info.seat_id == 4)
					{						
						_dealer.setPokers(vec);
					}
					else
					{
						_players[info.seat_id].setPokers(vec);	
					}					
				}
			}
		}
		
		public function startNewGame() : void
		{
			juggler.delayCall(reset, 6);
		}
		
		public function reset() : void
		{		
			_dealer.setPokers([0, 0, 0, 0, 0]);
			for (var i:int = 0; i < 4; ++i)
			{
				_players[i].seatId = i;
				_players[i].setPokers([0, 0, 0, 0, 0]);
				_players[i].betButton.visible = true;
			}
		}
	}
}