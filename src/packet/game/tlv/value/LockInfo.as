package packet.game.tlv.value
{
	import flash.utils.ByteArray;
		
	import packet.game.tlv.TLVValue;

	public class LockInfo extends TLVValue
	{
		public var lock_type:int;				// short(2)
		public var locked_server_id:int;		// short(2)
		public var locked_room_id:int;			// short(2)
		public var extend_buf_len:int;			// short(2)
		public var extend_buf:String;			// char[]

		public function LockInfo()
		{
			super();
		}
		
		/*
		override public function getValueType() : int
		{
			return TLVType.DN_TLV_LOCK_INFO;
		}
		*/

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeShort(lock_type);
			bytes.writeShort(locked_server_id);
			bytes.writeShort(locked_room_id);
			bytes.writeShort(extend_buf_len);
			if (extend_buf_len > 0)
			{
				bytes.writeUTFBytes(extend_buf);
			}
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			lock_type = bytes.readShort();
			locked_server_id = bytes.readShort();
			locked_room_id = bytes.readShort();
			extend_buf_len = bytes.readShort();
			if (extend_buf_len > 0)
			{
				extend_buf = bytes.readUTFBytes(extend_buf_len);
			}
			
			super.adjustPosition(bytes);
		}
	}
}