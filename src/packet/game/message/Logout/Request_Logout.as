package packet.game.message.Logout
{
	import flash.utils.ByteArray;
	
	import packet.game.message.MSGID;
	import packet.protocol.NiuRequestPacket;
	
	public class Request_Logout extends NiuRequestPacket
	{
		public var reason:int;			// short(2)

		public function Request_Logout()
		{
			super();
		}
		
		override protected function defineMsgId() : int
		{
			return MSGID.REQUEST_LOGOUT;
		}

		override public function packMsgParam(bytes:ByteArray) : void
		{
			bytes.writeShort(reason);
		}
	}
}