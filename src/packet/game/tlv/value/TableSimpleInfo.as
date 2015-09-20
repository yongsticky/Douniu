package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
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
			

		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			table_id = bytes.readShort();
			table_status = bytes.readShort();
			table_seat_num = bytes.readShort();
			cur_player_num = bytes.readShort();
			cur_viewer_num = bytes.readShort();
			

		}

		override public function printValue(logger:ILogger) : void
		{
			logger.log(this, "**************************************", LEVEL.INFO);
			logger.log(this, "print TableSimpleInfo value", LEVEL.INFO);
			logger.log(this, "table_id:", table_id, LEVEL.INFO);
			logger.log(this, "table_status:", table_status, LEVEL.INFO);
			logger.log(this, "table_seat_num:", table_seat_num, LEVEL.INFO);
			logger.log(this, "cur_player_num:", cur_player_num, LEVEL.INFO);
			logger.log(this, "cur_viewer_num:", cur_viewer_num, LEVEL.INFO);
			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}