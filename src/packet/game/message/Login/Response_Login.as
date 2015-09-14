package packet.game.message.Login
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
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
		
		override public function onObjectRecycled() : void
		{
			super.onObjectRecycled();
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:UnionTLV in tlv_vec)
			{					
				_factory.destroyInstance(item);
			}
			
			tlv_num = 0;
			tlv_vec.length = 0;
		}
		
		override public function printResponse(logger:ILogger) : void
		{
			logger.log(this, "***********************************************", LEVEL.INFO);
			logger.log(this, "print Response_Login.", LEVEL.INFO);			
			
			logger.log(this, "result:", rresult.result_id, LEVEL.INFO);
			logger.log(this, "recommend_scene_id:", recommend_scene_id, LEVEL.INFO);
			logger.log(this, "room_id:", room_id, LEVEL.INFO);
			logger.log(this, "room_table_num:",room_table_num, LEVEL.INFO);
			logger.log(this, "room_player_num:", room_player_num, LEVEL.INFO);
			logger.log(this, "room_ticket:", room_ticket, LEVEL.INFO);
			logger.log(this, "player_id:", player_id, LEVEL.INFO);
			logger.log(this, "trigger_present_beans:", trigger_present_beans, LEVEL.INFO);
			logger.log(this, "tlv_num:", tlv_num, LEVEL.INFO);
			for each(var tlv:UnionTLV in tlv_vec)
			{
				logger.log(this, "tlvType:", tlv.valueType, LEVEL.INFO);
				tlv.value.printValue(logger);
			}
			logger.log(this, "control_flag:", control_flag, LEVEL.INFO);
			logger.log(this, "talk_switch:", talk_switch, LEVEL.INFO);						
			
			logger.log(this, "***********************************************", LEVEL.INFO);
		}
	}
}