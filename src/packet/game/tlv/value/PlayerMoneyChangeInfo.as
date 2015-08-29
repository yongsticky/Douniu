package packet.game.tlv.value
{
	import packet.util.Int64;
	import flash.utils.ByteArray;

	public class PlayerMoneyChangeInfo extends TLVValue
	{
		public var money_change_reason:int;		// short(2)
		public var money_change_value:Int64;	// int64(8)
		public var money_cur_value:Int64;		// int64(8)

		public function PlayerMoneyChangeInfo()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack();

			bytes.writeShort(money_change_reason);
			money_change_value.writeToBytes(bytes);
			money_cur_value.writeToBytes(bytes);		
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack();

			money_change_reason = bytes.readShort();
			money_change_value.readFromBytes(bytes);
			money_cur_value.readFromBytes(bytes);			
		}
	}
}