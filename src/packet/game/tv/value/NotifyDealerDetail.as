package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tv.TVValue;
	
	public class NotifyDealerDetail extends TVValue
	{
		public var seat_id:int;			// byte(1)
		public var multiple:int;			// byte(1)
				
		public function NotifyDealerDetail()
		{
			super();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			seat_id = bytes.readByte();
			multiple = bytes.readByte();
			
			super.unpack(bytes);
		}

		override public function printValue(logger:ILogger) : void
		{		
			logger.log(this, "**************************************", LEVEL.INFO);			
			logger.log(this, "print NotifyDealerDetail value", LEVEL.INFO);
			
			logger.log(this, "seat_id:", seat_id, LEVEL.INFO);
			logger.log(this, "multiple:", int(multiple), LEVEL.INFO);
			
			super.printValue(logger);

			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}