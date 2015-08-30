package packet.game.message.Logout
{
	import flash.utils.ByteArray;
	
	import packet.protocol.NiuRequestPacket;
	
	public class Request_Logout extends NiuRequestPacket
	{
		public var reason:int;			// short(2)

		public function Request_Logout()
		{
			super();
		}

		override public function packMsgParam(bytes:ByteArray) : void
		{
			bytes.writeShort(reason);
		}
	}
}