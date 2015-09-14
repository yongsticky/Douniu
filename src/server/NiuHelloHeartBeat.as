package server
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import global.GlobalSharedData;
	
	import packet.game.message.Hello.Request_Hello;
	
	public class NiuHelloHeartBeat
	{
		protected var _logger:ILogger;
		
		private var _timer:Timer;
		private var _now:Date;
		private var _request:Request_Hello;
		
		private var _count:int = 0;
		
		
		
		private static var _instance:NiuHelloHeartBeat = null;
		public static function instance() : NiuHelloHeartBeat
		{
			if (!_instance)
			{
				_instance = new NiuHelloHeartBeat(new PrivateInner());
			}
			
			return _instance;
		}		
		
		
		public function NiuHelloHeartBeat(inner:PrivateInner)
		{
			_logger = Logger.createLogger(NiuHelloHeartBeat, LEVEL.INFO);			
		}
		
		public function start() : void
		{
			_now = new Date();
			_request = new Request_Hello();
			
			_timer = new Timer(30000, 0);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();			
		}
			
		
		public function stop() : void
		{
			_timer.stop();			
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			_logger.log(this, "Send Heart Beat Hello.", LEVEL.INFO);
			
			_request.csHeader.uin = GlobalSharedData.instance().uin;
						
			_request.time = _now.getTime() + 60*1000*_count;
			
			_count ++;
			
			
			NiuRequestSender.instance().sendRequest(_request);
		}
	}
}

class PrivateInner
{
	
}