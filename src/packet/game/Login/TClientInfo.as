package packet.game.Login
{	
	import flash.utils.ByteArray;
	
	import camu.util.BigIntUtil;	

	public class TClientInfo
	{
		public var nick_len:int;			// short(2)
		public var nick:String;			// char[]
		public var age:int;				// char(1)
		public var gender:int;				// char(1)
		public var account_type:int;		// short(2)
		public var client_type:int;		// short(2)
		public var pf_key_h:int;			//
		public var pf_key_l:int;			// bigint(8)
		public var network_type:int;		// short(2)
		public var operator:int;			// short(2)
		public var channel:int;			// int(4)
		public var client_version:uint;	// unsigned int(4)
		public var os_version_len:int;		// short(2)
		public var os_version:String;		// char[]
		public var terminal_len:int;		// short(2)
		public var termnal:String;			// char[]
		public var open_id_len:int;		// short(2)
		public var open_id:String;			// char[]
		public var head_url_len:int;		// short(2)
		public var head_url:String;		// char[]
		
		
		public function TClientInfo()
		{
			nick_len = 0;
			age = 20;
			gender = 77;		// 'M'
			account_type = 0;
			client_type = 64;
			pf_key_h = 0;
			pf_key_l = 0;
			network_type = 1;
			operator = 0;
			channel = 0;
			client_version = 0;
			os_version_len = 0;
			terminal_len = 0;
			open_id_len = 0;
			head_url_len = 0;
			
		}
		
		public function pack(bytes:ByteArray) : void
		{					
			//ShortIntUtil.writeShortInt(bytes, nick_len);
			bytes.writeShort(nick_len);
			if (nick_len > 0)
			{				
			}
			bytes.writeByte(age);
			bytes.writeByte(gender);
			//ShortIntUtil.writeShortInt(bytes, account_type);
			bytes.writeShort(account_type);
			//ShortIntUtil.writeShortInt(bytes, client_type);
			bytes.writeShort(client_type);
			BigIntUtil.writeBigInt(bytes, pf_key_l, pf_key_h);
			//ShortIntUtil.writeShortInt(bytes, network_type);
			bytes.writeShort(network_type);
			//ShortIntUtil.writeShortInt(bytes, operator);
			bytes.writeShort(operator);
			bytes.writeInt(channel);
			bytes.writeUnsignedInt(client_version);
			//ShortIntUtil.writeShortInt(bytes, os_version_len);
			bytes.writeShort(os_version_len);
			if (os_version_len > 0)
			{				
			}
			//ShortIntUtil.writeShortInt(bytes, terminal_len);
			bytes.writeShort(terminal_len);
			if (terminal_len > 0)
			{				
			}
			//ShortIntUtil.writeShortInt(bytes, open_id_len);
			bytes.writeShort(open_id_len);
			if (open_id_len > 0)
			{				
			}
			//ShortIntUtil.writeShortInt(bytes, head_url_len);
			bytes.writeShort(head_url_len);
			if (head_url_len > 0)
			{				
			}					
		
		}
	}
}