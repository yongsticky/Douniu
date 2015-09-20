package packet.game.message.Standup
{
	import flash.utils.ByteArray;
	
	import packet.game.message.MSGID;

	import packet.protocol.NiuRequestPacket;
	
	public class Request_Standup extends NiuRequestPacket
	{
		public var standup_flag:int;				// int(4)
		public var room_id:int;						// short(2)

		public function Request_Standup()
		{			
			super();
		}
		
		override protected function defineMsgId() : int
		{
			return MSGID.REQUEST_STANDUP;
		}

		override public function packMsgParam(bytes:ByteArray) : void
		{
			bytes.writeInt(standup_flag);
			bytes.writeShort(room_id);
		}
	}
}