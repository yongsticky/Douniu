package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;

	public class TableSimpleInfo extends TLVValue
	{
		public var table_id:int;			// short(2)
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
			super.pack(bytes);

			bytes.writeShort(table_id);
			bytes.writeShort(table_status);
			bytes.writeShort(table_seat_num);
			bytes.writeShort(cur_player_num);
			bytes.writeShort(cur_viewer_num);
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			table_id = bytes.readShort();
			table_status = bytes.readShort();
			table_seat_num = bytes.readShort();
			cur_player_num = bytes.readShort();
			cur_viewer_num = bytes.readShort();
			
			super.adjustPosition(bytes);
		}
	}
}