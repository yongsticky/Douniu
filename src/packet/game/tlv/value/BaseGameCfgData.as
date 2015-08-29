package packet.game.tlv.value
{
	import packet.util.Int64;
	import flash.utils.ByteArray;

	public class BaseGameCfgData extends TLVValue
	{
		public var min_money_limit:uint;					// unsigned int(4)
		public var max_money_limit:Int64;					// int64(8)
		public var rcmd_buy_commodity_type:uint;			// unsigned int(4)
		public var room_max_game_money_limit:uint;			// unsigned int(4)
		public var room_ticket:uint;						// unsigned int(4)
		public var result_type:uint;	

						// unsigned int(4)
		public function BaseGameCfgData()
		{
			super();
		}


		override public function pack(bytes:ByteArray) : void
		{
			bytes.writeUnsignedInt(min_money_limit);
			max_money_limit.writeToBytes(bytes);
			bytes.writeUnsignedInt(rcmd_buy_commodity_type);
			bytes.writeUnsignedInt(room_max_game_money_limit);
			bytes.writeUnsignedInt(room_ticket);
			bytes.writeUnsignedInt(result_type);
		}

		override public function unpack(bytes:ByteArray) : void
		{
			min_money_limit = bytes.readUnsignedInt();
			max_money_limit.readFromBytes(bytes);
			rcmd_buy_commodity_type = bytes.readUnsignedInt();
			room_max_game_money_limit = bytes.readUnsignedInt();
			room_ticket = bytes.readUnsignedInt();
			result_type = bytes.readUnsignedInt();
		}
	}
}