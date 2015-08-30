package packet.game.message.Sitdown
{
	import flash.utils.ByteArray;
		
	import packet.protocol.NiuResponsePacket;
	import packet.game.tlv.UnionTLV;	
	import packet.game.tlv.UnionTLVDecoder;
	import packet.game.message.ResponseResult;
	
	
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
	}
}