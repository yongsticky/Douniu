package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class ExitPlayerInfo extends TLVValue
	{
		public var standup_reason:int;		// short(2)

		public function ExitPlayerInfo() 
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack();

			bytes.writeShort(standup_reason);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack();

			standup_reason = bytes.readShort();
		}
	}
}