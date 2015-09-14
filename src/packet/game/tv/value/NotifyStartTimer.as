package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tv.TVValue;
	
	public class NotifyStartTimer extends TVValue
	{
		public var flag:int;			// char(1)
				
		public function NotifyStartTimer()
		{		
			super();
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			flag = bytes.readByte();
			
			super.unpack(bytes);
		}
		
		override public function printValue(logger:ILogger) : void
		{		
			logger.log(this, "**************************************", LEVEL.INFO);			
			logger.log(this, "print NotifyStartTimer value", LEVEL.INFO);
			
			logger.log(this, "flag:", flag, LEVEL.INFO);	
			
			super.printValue(logger);
			
			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}