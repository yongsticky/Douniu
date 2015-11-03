package packet.game.message.Sitdown
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.ResponseResult;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVDecoder;
	import packet.protocol.NiuResponsePacket;
	
	
	public class Response_Sitdown extends NiuResponsePacket
	{	
		public var rresult:ResponseResult;			// ?
		public var room_id:int;						// short(2)
		public var table_id:int;					// short(2)
		public var seat_id:int;						// short(2)
		public var table_seat_num:int;				// short(2)
		public var cur_player_num:int;				// short(2)
		public var cur_viewer_num:int;				// short(2)
		public var tlv_num:int;						// short(2)
		public var tlv_vec:Vector.<UnionTLV>;		// ?


		public function Response_Sitdown()
		{
			super();
			
			rresult = new ResponseResult();
			tlv_vec = new Vector.<UnionTLV>();
		}

		override public function unpackMsgParam(bytes:ByteArray) : void
		{			
			rresult.unpack(bytes);
			room_id = bytes.readShort();
			table_id = bytes.readShort();
			seat_id = bytes.readShort();
			table_seat_num = bytes.readShort();
			cur_player_num = bytes.readShort();
			cur_viewer_num = bytes.readShort();
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
			logger.log(this, "print Response_Sitdown.", LEVEL.INFO);			
			
			logger.log(this, "result:", rresult.result_id, LEVEL.INFO);
			logger.log(this, "result_str:", rresult.result_str, LEVEL.INFO);
			logger.log(this, "room_id:", room_id, LEVEL.INFO);
			logger.log(this, "table_id:",table_id, LEVEL.INFO);
			logger.log(this, "seat_id:", seat_id, LEVEL.INFO);
			logger.log(this, "table_seat_num:", table_seat_num, LEVEL.INFO);
			logger.log(this, "cur_player_num:", cur_player_num, LEVEL.INFO);
			logger.log(this, "cur_viewer_num:", cur_viewer_num, LEVEL.INFO);
			logger.log(this, "tlv_num:", tlv_num, LEVEL.INFO);
			for each(var tlv:UnionTLV in tlv_vec)
			{
				logger.log(this, "tlvType:", tlv.valueType, LEVEL.INFO);	
				tlv.value.printValue(logger);
			}									
			
			logger.log(this, "***********************************************", LEVEL.INFO);
		}
	}
}