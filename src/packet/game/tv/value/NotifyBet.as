package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tv.TVValue;
	
	public class NotifyBet extends TVValue
	{
		public var multiple_num:int;			// short(2)
		public var multiple:ByteArray;			// char[]
				
		public function NotifyBet()
		{
			super();
			
			multiple = new ByteArray();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			multiple_num = bytes.readShort();
			bytes.readBytes(multiple, 0, multiple_num);
			
			super.unpack(bytes);
		}
		
		override public function dispose() : void
		{
			trace("dispose");
			
			multiple.clear();
			multiple_num = 0;
			
			super.dispose();
		}

		override public function printValue(logger:ILogger) : void
		{		
			logger.log(this, "**************************************", LEVEL.INFO);			
			logger.log(this, "print NotifyBet value", LEVEL.INFO);
			
			logger.log(this, "multiple_num:", multiple_num, LEVEL.INFO);
			for (var i:int = 0; i < multiple_num; ++i)
			{
				logger.log(this, "multiple[", i, "] = ", multiple[i], LEVEL.INFO);	
			}			
			
			super.printValue(logger);

			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}