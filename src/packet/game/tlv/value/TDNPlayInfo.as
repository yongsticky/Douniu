package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	import packet.game.tlv.value.TLVValue;
	
	public class TDNPlayInfo extends TLVValue
	{
		public var vip_level:int;		// Byte(1)

		public function TDNPlayInfo()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(vip_level);
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			vip_level = bytes.readByte();
			
			super.adjustPosition(bytes);
		}
	}
}