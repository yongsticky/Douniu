package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tlv.TLVValue;
	import packet.util.Int64;

	public class PlayerMoneyChangeInfo extends TLVValue
	{
		public var money_change_reason:int;		// short(2)
		public var money_change_value:Int64;	// int64(8)
		public var money_cur_value:Int64;		// int64(8)

		public function PlayerMoneyChangeInfo()
		{
			super();
			
			money_change_value = new Int64();
			money_cur_value = new Int64();
		}
				
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeShort(money_change_reason);
			money_change_value.writeToBytes(bytes);
			money_cur_value.writeToBytes(bytes);	
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			money_change_reason = bytes.readShort();
			money_change_value.readFromBytes(bytes);
			money_cur_value.readFromBytes(bytes);
		}
		
		override public function printValue(logger:ILogger):void
		{
			logger.log(this, "**************************************************", LEVEL.INFO);
			logger.log(this, "print PlayerMoneyChangeInfo value", LEVEL.INFO);
			logger.log(this, "money_change_reason:", money_change_reason, LEVEL.INFO);
			logger.log(this, "money_change_value.highPart:", money_change_value.highPart, LEVEL.INFO);
			logger.log(this, "money_change_value.lowPart:", money_change_value.lowPart, LEVEL.INFO);
			logger.log(this, "money_cur_value.highPart:", money_cur_value.highPart, LEVEL.INFO);
			logger.log(this, "money_cur_value.lowPart:", money_cur_value.lowPart, LEVEL.INFO);
			
			logger.log(this, "**************************************************", LEVEL.INFO);
		}
	}
}