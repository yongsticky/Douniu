package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	import packet.util.Int64;

	public class PlayerCapability extends TLVValue
	{
		public var client_capability:Int64;
	
		public function PlayerCapability()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack();

			client_capability.writeToBytes(bytes);		
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack();

			client_capability.readFromBytes(bytes);
		}
	}
}