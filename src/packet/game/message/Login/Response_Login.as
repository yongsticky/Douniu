package packet.game.message.Login
{
	import flash.utils.ByteArray;
	
	import camu.design_pattern.Singleton;
	
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVDecoder;
	import packet.protocol.NiuResponsePacket;
	
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
		public var tlv_vec:Vector.<UnionTLV>;	// TTLVUINT[]
		public var control_flag:int;		// unsigned int(4)
		public var talk_switch:int;		// unsigned int(4)
		
		
		public function Response_Login()
		{
			super();
			
			tlv_vec = new Vector.<UnionTLV>();
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
				var _uTLVDecoder:UnionTLVDecoder = Singleton.instanceOf(UnionTLVDecoder);
				for (var i:int = 0; i < tlv_num; i++)
				{
					var utlv:UnionTLV = _uTLVDecoder.decode(bytes);
					tlv_vec.push(utlv);
				}
			}
			control_flag = bytes.readUnsignedInt();
			talk_switch = bytes.readUnsignedInt();
		}
	}
}