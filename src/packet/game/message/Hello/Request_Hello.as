package packet.game.message.Hello
{
	import flash.utils.ByteArray;
	
	import packet.game.message.MSGID;
	import packet.protocol.NiuRequestPacket;
	
	public class Request_Hello extends NiuRequestPacket
	{
		public var time:uint;					// unsigned int(4)
		public var info_len:int;				// short(2)
		public var info:ByteArray;				// char[]
		
		public function Request_Hello()
		{
			super();
			
			info = new ByteArray();
		}
		
		override protected function initData() : void
		{
			msgHeader.msg_id = MSGID.REQUEST_HELLO;
		}
		
		override public function packMsgParam(bytes:ByteArray) : void
		{
			bytes.writeUnsignedInt(time);
			bytes.writeShort(info_len);
			bytes.writeBytes(info, 0, info_len);			
		}
		
		override public function onObjectRecycled() : void
		{
			info.clear();
			info_len = 0;
			time = 0;
			
			super.onObjectRecycled();
		}
	}
}