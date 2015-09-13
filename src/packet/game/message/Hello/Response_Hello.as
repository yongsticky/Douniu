package packet.game.message.Hello
{
	import flash.utils.ByteArray;
	
	import packet.protocol.NiuResponsePacket;
	
	public class Response_Hello extends NiuResponsePacket
	{
		public var result:uint;			// unsigned int(4)
		
		public function Response_Hello()
		{
			super();
		}
		
		override public function unpackMsgParam(bytes:ByteArray) : void
		{
			result = bytes.readUnsignedInt();
		}
	}
}