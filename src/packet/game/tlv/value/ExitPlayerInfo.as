package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tlv.TLVValue;
	

	public class ExitPlayerInfo extends TLVValue
	{
		public var standup_reason:int;		// short(2)

		public function ExitPlayerInfo() 
		{
			super();			
		}
				
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeShort(standup_reason);
			

		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			standup_reason = bytes.readShort();
			

		}

		override public function printValue(logger:ILogger) : void
		{
			logger.log(this, "**************************************", LEVEL.INFO);
			logger.log(this, "print ExitPlayerInfo value", LEVEL.INFO);
			logger.log(this, "standup_reason:", standup_reason, LEVEL.INFO);			
			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}