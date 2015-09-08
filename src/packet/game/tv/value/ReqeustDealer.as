package packet.game.tv.value
{
	import packet.game.tv.TVValue;

	public class ReqeustDealer extends TVValue
	{
		public var times:int;				// Byte(1)
				
		public function ReqeustDealer()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			bytes.writeByte(times);

			super.pack(bytes);
		}

		override public function unpack(bytes:ByteArray) : void
		{
			
		}
	}
}