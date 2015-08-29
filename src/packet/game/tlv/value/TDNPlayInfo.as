package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	import packet.game.tlv.value.TLVValue;
	
	public class TDNPlayInfo extends TLVValue
	{
		public var vip_level:int;		// Byte(8)

		public function TDNPlayInfo()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			bytes.writeByte(vip_level);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			vip_level = bytes.readByte();
		}
	}
}