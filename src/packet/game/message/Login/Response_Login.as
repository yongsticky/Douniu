package packet.game.message.Login
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.ResponseResult;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVDecoder;
	import packet.protocol.NiuResponsePacket;
	
	public class Response_Login extends NiuResponsePacket
	{	
		public var rresult:ResponseResult;			// ?
		public var recommend_scene_id:int;			// unsigned int(4)
		public var room_id:int;					// short(2)
		public var room_table_num:int;				// unsigned int(4)
		public var room_player_num:int;			// unsigned int(4)
		public var room_ticket:int;				// unsigned int(4)
		public var player_id:int;					// unsigned int(4)
		public var trigger_present_beans:int;		// unsigned int(4)
		public var tlv_num:int;					// short(2)
		public var tlv_vec:Vector.<UnionTLV>;		// TTLVUINT[]
		public var control_flag:int;				// unsigned int(4)
		public var talk_switch:int;				// unsigned int(4)
		
		
		public function Response_Login()
		{
			super();
			
			rresult = new ResponseResult();
			tlv_vec = new Vector.<UnionTLV>();
		}
		
		override public function unpackMsgParam(bytes:ByteArray):void
		{	
			rresult.unpack(bytes);
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
				var _uTLVDecoder:UnionTLVDecoder = UnionTLVDecoder.instance();
				for (var i:int = 0; i < tlv_num; i++)
				{
					var utlv:UnionTLV = _uTLVDecoder.decode(bytes);					
					tlv_vec.push(utlv);
				}
			}
			control_flag = bytes.readUnsignedInt();
			talk_switch = bytes.readUnsignedInt();
		}
		
		override public function dispose() : void
		{
			super.dispose();
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:UnionTLV in tlv_vec)
			{				
				_factory.destroyInstance(item);
			}
			
			tlv_num = 0;
			tlv_vec.length = 0;
		}
	}
}