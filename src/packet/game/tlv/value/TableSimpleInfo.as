package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class TableSimpleInfo extends TLVValue
	{
		public var table_status:int;		// short(2)
		public var table_seat_num:int;		// short(2)
		public var cur_player_num:int;		// short(2)
		public var cur_viewer_num:int;		// short(2)

		public function TableSimpleInfo()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack();

			bytes.writeShort(table_status);
			bytes.writeShort(table_seat_num);
			bytes.writeShort(cur_player_num);
			bytes.writeShort(cur_viewer_num);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack();

			table_status = bytes.readShort();
			table_seat_num = bytes.readShort();
			cur_player_num = bytes.readShort();
			cur_viewer_num = bytes.readShort();
		}
	}
}