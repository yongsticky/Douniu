package packet.game.tlv.value
{
	import flash.utils.ByteArray;
		
	import packet.game.tlv.TLVValue;
	import packet.util.Int64;

	public class PlayerCapability extends TLVValue
	{
		public var client_capability:Int64;
	
		public function PlayerCapability()
		{
			super();
			
			client_capability = new Int64();
		}
		
		/*
		override public function getValueType() : int
		{
			return TLVType.DN_TLV_PLAYER_CAPABILITY;
		}
		*/

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			client_capability.writeToBytes(bytes);	
			

		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			client_capability.readFromBytes(bytes);
			

		}
	}
}