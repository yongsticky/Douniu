package packet.game.tlv
{
	import flash.utils.ByteArray;

	public class UTLV
	{
		public var type_:int;
		public var len:int;
		public var value:ByteArray;
		
		public function UTLV()
		{
			value = new ByteArray();
		}
		
		
		public function unpack(bytes:ByteArray) : void
		{
			type_ = bytes.readShort();
			len = bytes.readShort();
			if (len > 0)
			{
				bytes.readBytes(value, 0, len);
			}
		}
	}
}