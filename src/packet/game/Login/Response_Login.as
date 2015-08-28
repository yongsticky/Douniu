package packet.game.Login
{
	import flash.utils.ByteArray;
	
	import packet.protocol.NiuResponsePacket;
	
	public class Response_Login extends NiuResponsePacket
	{
		public function Response_Login()
		{
			super();
		}
		
		override public function unpackMsgParam(bytes:ByteArray):void
		{
			trace("Response_Login::unpackMsgParam bytes.positon=", bytes.position, ", bytesAvailable=", bytes.bytesAvailable);
		}
	}
}