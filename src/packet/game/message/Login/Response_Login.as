package packet.game.message.Login
{
	import flash.utils.ByteArray;
	
	import packet.protocol.NiuResponsePacket;
	import packet.game.tlv.UTLV;
	
	public class Response_Login extends NiuResponsePacket
	{
		
		public var result_id:int;			// unsigned int(4）
		public var result_str_len:int;		// short(2)
		public var result_str:String;		// char[]
		public var recommend_scene_id:int;	// unsigned int(4)
		public var room_id:int;			// short(2)
		public var room_table_num:int;		// unsigned int(4)
		public var room_player_num:int;	// unsigned int(4)
		public var room_ticket:int;		// unsigned int(4)
		public var player_id:int;			// unsigned int(4)
		public var trigger_present_beans:int;	// unsigned int(4)
		public var tlv_num:int;			// short(2)
		public var tlv_vec:Vector.<UTLV>;	// TTLVUINT[]
		public var control_flag:int;		// unsigned int(4)
		public var talk_switch:int;		// unsigned int(4)
		
		
		public function Response_Login()
		{
			super();
			
			tlv_vec = new Vector.<UTLV>();
		}
		
		override public function unpackMsgParam(bytes:ByteArray):void
		{
			trace("Response_Login::unpackMsgParam bytes.positon=", bytes.position, ", bytesAvailable=", bytes.bytesAvailable);
			
			result_id = bytes.readUnsignedInt();
			result_str_len = bytes.readShort();
			if (result_str_len > 0)
			{
				result_str = bytes.readUTFBytes(result_str_len);
			}
			recommend_scene_id = bytes.readUnsignedInt();
			room_id = bytes.readShort();
			room_table_num = bytes.readUnsignedInt();
			room_player_num = bytes.readUnsignedInt();
			room_ticket = bytes.readUnsignedInt();
			player_id = bytes.readUnsignedInt();
			trigger_present_beans = bytes.readUnsignedInt();
			tlv_num = bytes.readShort();
			if (tlv_num > 0)
			{				
				for (var i:int = 0; i < tlv_num; i++)
				{
					var tlvInfo:UTLV = new UTLV();
					tlvInfo.unpack(bytes);
					tlv_vec.push(tlvInfo);
				}
			}
			control_flag = bytes.readUnsignedInt();
			talk_switch = bytes.readUnsignedInt();			
		}
	}
}