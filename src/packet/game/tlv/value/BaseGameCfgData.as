package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.util.Int64;

	public class BaseGameCfgData extends TLVValue
	{
		public var min_money_limit:uint;					// unsigned int(4)
		public var max_money_limit:Int64;					// int64(8)
		public var rcmd_buy_commodity_type:uint;			// unsigned int(4)
		public var room_max_game_money_limit:uint;			// unsigned int(4)
		public var room_ticket:uint;						// unsigned int(4)
		public var result_type:uint;						// unsigned int(4)

						
		public function BaseGameCfgData()
		{
			super();
			
			max_money_limit = new Int64();
		}


		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeUnsignedInt(min_money_limit);
			max_money_limit.writeToBytes(bytes);
			bytes.writeUnsignedInt(rcmd_buy_commodity_type);
			bytes.writeUnsignedInt(room_max_game_money_limit);
			bytes.writeUnsignedInt(room_ticket);
			bytes.writeUnsignedInt(result_type);
			
			super.adjustPosition(bytes);
		}

		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			min_money_limit = bytes.readUnsignedInt();
			max_money_limit.readFromBytes(bytes);
			rcmd_buy_commodity_type = bytes.readUnsignedInt();
			room_max_game_money_limit = bytes.readUnsignedInt();
			room_ticket = bytes.readUnsignedInt();
			result_type = bytes.readUnsignedInt();
			
			super.adjustPosition(bytes);
		}
	}
}