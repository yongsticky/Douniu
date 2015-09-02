package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class TPlayerKickOutInfo extends TLVValue
	{
		public var server_id:int;						// short(2)
		public var room_id:int;						// short(2)
		public var reason_id:int;					// int(4)
		public var result_str_len:int;				// short(2)
		public var result_str:String;				// char[]
		
		public function TPlayerKickOutInfo()
		{
			super();
		}
	

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
					
			bytes.writeShort(server_id);
			bytes.writeShort(room_id);
			bytes.writeInt(reason_id);
			
			bytes.writeShort(result_str_len);
			if (result_str_len > 0)
			{
				bytes.writeUTFBytes(result_str);
			}
						
			super.adjustPosition(bytes);
		}
				
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
				
			server_id = bytes.readShort();
			room_id = bytes.readShort();
			reason_id = bytes.readInt();
			
			result_str_len = bytes.readShort();
			if (result_str_len > 0)
			{
				result_str = bytes.readUTFBytes(result_str_len);
			}
				
			super.adjustPosition(bytes);
		}
	}
}