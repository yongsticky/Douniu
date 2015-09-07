package packet.game.tlv.value
{
	import flash.utils.ByteArray;
		
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
		
		/*
		override public function getValueType() : int
		{
			return TLVType.DN_TLV_MONEY_CHANGE_INFO;
		}
		*/

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeShort(money_change_reason);
			money_change_value.writeToBytes(bytes);
			money_cur_value.writeToBytes(bytes);	
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			money_change_reason = bytes.readShort();
			money_change_value.readFromBytes(bytes);
			money_cur_value.readFromBytes(bytes);	
			
			super.adjustPosition(bytes);
		}
	}
}