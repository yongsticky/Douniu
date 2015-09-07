package packet.game.tlv.value
{
	import flash.utils.ByteArray;
		
	import packet.game.tlv.TLVValue;
	import packet.util.Int64;

	public class PlayerViewSeatInfo extends TLVValue
	{
		public var player_id:int;		// int(4)
		public var player_uin:int;		// unsigned int(4)
		public var nick_len:int;		// short(2)
		public var nick:String;			// char[]
		public var age:int;				// char(1)
		public var gender:int;			// char(1)
		public var level:int;			// short(2)
		public var experience:int;		// unsigned int(4)
		public var money:Int64;			// int64(8)
		public var table_id:int;		// short(2)
		public var seat_id:int;			// short(2)
		public var player_status:int;	// short(2)
		public var client_type:int;		// int(4)
		public var accout_type:int;		// int(4)
		public var open_id_len:int;		// short(2)
		public var open_id:String;		// char[]
		public var head_url_len:int;	// short(2)
		public var head_url:String;		// char[]
		public var score:Int64;			// int64(8)

		public function PlayerViewSeatInfo()
		{
			super();
			
			money = new Int64();
			score = new Int64();
		}
		
		/*
		override public function getValueType() : int
		{
			return TLVType.DN_TLV_VIEW_SEAT_INFO;
		}
		*/

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeInt(player_id);
			bytes.writeInt(player_uin);
			bytes.writeShort(nick_len);
			if (nick_len > 0)
			{
				bytes.writeUTFBytes(nick)
			}
			bytes.writeByte(age);
			bytes.writeByte(gender);
			bytes.writeShort(level);
			bytes.writeUnsignedInt(experience);
			money.writeToBytes(bytes);
			bytes.writeShort(table_id);
			bytes.writeShort(seat_id);
			bytes.writeShort(player_status);
			bytes.writeInt(client_type);
			bytes.writeInt(accout_type);
			bytes.writeShort(open_id_len);
			if (open_id_len > 0)
			{
				bytes.writeUTFBytes(open_id);
			}
			bytes.writeShort(head_url_len);
			if (head_url_len > 0)
			{
				bytes.writeUTFBytes(head_url);
			}
			score.writeToBytes(bytes);
			
			super.adjustPosition(bytes);			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			player_id = bytes.readInt();
			player_uin = bytes.readUnsignedInt();			
			nick_len = bytes.readShort();
			if (nick_len > 0)
			{
				nick = bytes.readUTFBytes(nick_len);
			}
			age = bytes.readUnsignedByte();
			gender = bytes.readUnsignedByte();
			level = bytes.readShort();
			experience = bytes.readUnsignedInt();
			money.readFromBytes(bytes);			
			table_id = bytes.readShort();
			seat_id = bytes.readShort();
			player_status = bytes.readShort();
			client_type = bytes.readInt();
			accout_type = bytes.readInt();
			open_id_len = bytes.readShort();
			if (open_id_len > 0)
			{
				open_id = bytes.readUTFBytes(open_id_len);
			}			
			head_url_len = bytes.readShort();
			if (head_url_len > 0)
			{
				head_url = bytes.readUTFBytes(head_url_len);
			}
			score.readFromBytes(bytes);	
			
			super.adjustPosition(bytes);
		}
	}
}