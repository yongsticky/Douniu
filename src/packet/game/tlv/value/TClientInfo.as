package packet.game.tlv.value
{	
	import flash.utils.ByteArray;	
	import packet.util.Int64;

	public class TClientInfo extends TLVValue
	{
		public var nick_len:int;			// short(2)
		public var nick_str:String;			// char[]
		public var age:int;				// char(1)
		public var gender:int;				// char(1)
		public var account_type:int;		// short(2)
		public var client_type:int;		// short(2)
		public var pf_key:Int64;			// int64(8)
		public var network_type:int;		// short(2)
		public var operator:int;			// short(2)
		public var channel:int;			// int(4)
		public var client_version:uint;	// unsigned int(4)
		public var os_version_len:int;		// short(2)
		public var os_version:String;		// char[]
		public var terminal_len:int;		// short(2)
		public var terminal_str:String;	// char[]
		public var open_id_len:int;		// short(2)
		public var open_id:String;			// char[]
		public var head_url_len:int;		// short(2)
		public var head_url:String;		// char[]
		
		
		public function TClientInfo()
		{
			super();
			
			pf_key = new Int64();
			

			nick_len = 0;
			age = 20;
			gender = 77;		// 'M'
			account_type = 0;
			client_type = 64;
			pf_key.lowPart = pf_key.highPart = 0;
			network_type = 1;
			operator = 0;
			channel = 0;
			client_version = 0;
			os_version_len = 0;
			terminal_len = 0;
			open_id_len = 0;
			head_url_len = 0;
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			//super.pack(bytes);
			
			bytes.writeShort(nick_len);
			if (nick_len > 0)
			{
				bytes.writeUTFBytes(nick_str);
			}
			bytes.writeByte(age);
			bytes.writeByte(gender);
			bytes.writeShort(account_type);
			bytes.writeShort(client_type);
			pf_key.writeToBytes(bytes);
			bytes.writeShort(network_type);
			bytes.writeShort(operator);
			bytes.writeInt(channel);
			bytes.writeUnsignedInt(client_version);			
			bytes.writeShort(os_version_len);
			if (os_version_len > 0)
			{
				bytes.writeUTFBytes(os_version);
			}
			bytes.writeShort(terminal_len);
			if (terminal_len > 0)
			{
				bytes.writeUTFBytes(terminal_str);
			}
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
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			nick_len = bytes.readShort();
			if (nick_len > 0)
			{
				nick_str = bytes.readUTFBytes(nick_len);
			}
			age = bytes.readByte();
			gender = bytes.readByte();
			account_type = bytes.readShort();
			client_type = bytes.readShort();
			pf_key.readFromBytes(bytes);
			network_type = bytes.readShort();
			operator = bytes.readShort();
			channel = bytes.readInt();
			client_version = bytes.readUnsignedInt();
			os_version_len = bytes.readShort();
			if (os_version_len > 0)
			{
				os_version = bytes.readUTFBytes(os_version_len);
			}
			terminal_len = bytes.readShort();
			if (terminal_len > 0)
			{
				terminal_str = bytes.readUTFBytes(terminal_len);	
			}
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
		}
	}
}