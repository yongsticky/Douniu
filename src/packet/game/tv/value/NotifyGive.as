package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tv.TVValue;	
	
	public class NotifyGive extends TVValue
	{	
		public function NotifyGive()
		{
			super();				
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
		}
		
		override public function dispose() : void
		{
			super.dispose();
		}

		override public function printValue(logger:ILogger) : void
		{		
			logger.log(this, "**************************************", LEVEL.INFO);			
			logger.log(this, "print NotifyGive value", LEVEL.INFO);			
			
			super.printValue(logger);

			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}