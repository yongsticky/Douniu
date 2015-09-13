package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	import packet.game.tlv.TLVValue;

	public class ExitPlayerInfo extends TLVValue
	{
		public var standup_reason:int;		// short(2)

		public function ExitPlayerInfo() 
		{
			super();			
		}
				
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeShort(standup_reason);
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			standup_reason = bytes.readShort();
			
			super.adjustPosition(bytes);
		}
	}
}