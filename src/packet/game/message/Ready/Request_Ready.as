package packet.game.message.Ready
{
	import flash.utils.ByteArray;

	import packet.protocol.NiuRequestPacket;
	import packet.game.tlv.UnionTLV;
	
	public class Request_Ready extends NiuRequestPacket
	{
		public var ready_mode:int;				// short(2)
		public var room_id:int;					// short(2)
		public var table_id:int;				// short(2)
		public var tlv_num:int;					// short(2)
		public var tlv_vec:Vector.<UnionTLV>;	// ?

		public function Request_Ready()
		{
			super();
			
			tlv_vec = new Vector.<UnionTLV>();
		}

		override public function packMsgParam(bytes:ByteArray) : void
		{
			bytes.writeShort(ready_mode);
			bytes.writeShort(room_id);
			bytes.writeShort(table_id);
			bytes.writeShort(tlv_num);
			for (var i:int = 0; i < tlv_num; i++)
			{
				tlv_vec[i].pack(bytes);
			}
		}
	}
}