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
		public var extend_buf:ByteArray;		// char[]

		public function LockInfo()
		{
			super();
			
			extend_buf = new ByteArray();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeShort(lock_type);
			bytes.writeShort(locked_server_id);
			bytes.writeShort(locked_room_id);
			bytes.writeShort(extend_buf_len);
			if (extend_buf_len > 0)
			{
				bytes.writeBytes(extend_buf, 0, extend_buf_len);
			}
			

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
				bytes.readBytes(extend_buf, 0, extend_buf_len);
			}
			

		}
		
		override public function onObjectRecycled() : void
		{
			extend_buf.clear();
			extend_buf_len = 0;
			lock_type = 0;
			locked_server_id = 0;
			locked_room_id = 0;
		}
	}
}