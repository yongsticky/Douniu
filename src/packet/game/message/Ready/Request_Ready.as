package packet.game.message.Ready
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.MSGID;
	import packet.game.message.Notify.TGameEvent;
	import packet.game.tlv.UnionTLV;
	import packet.protocol.NiuRequestPacket;
	
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
		
		override protected function initData():void
		{
			msgHeader.msg_id = MSGID.REQUEST_READY;
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