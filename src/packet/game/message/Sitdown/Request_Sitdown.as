package packet.game.message.Sitdown
{
	import flash.utils.ByteArray;

	import packet.protocol.NiuRequestPacket;
	import packet.game.tlv.UnionTLV;
	
	public class Request_Sitdown extends NiuRequestPacket
	{	
		public var sitdown_flag:int;			// int(4)
		public var room_id:int;					// short(2)
		public var table_id:int;				// short(2)
		public var seat_id:int;					// shor(2)
		public var tlv_num:int;					// short(2)
		public var tlv_vec:Vector.<UnionTLV>;	// ?

		public function Request_Sitdown()
		{
			super();

			tlv_vec = new Vector.<UnionTLV>();
		}

		override public function packMsgParam(bytes:ByteArray) : void
		{	
			bytes.writeInt(sitdown_flag);
			bytes.writeShort(room_id);
			bytes.writeShort(table_id);
			bytes.writeShort(seat_id);
			bytes.writeShort(tlv_num);
			for (var i:int = 0; i < tlv_num; i++)
			{
				tlv_vec[i].pack(bytes);
			}
		}
	}
}