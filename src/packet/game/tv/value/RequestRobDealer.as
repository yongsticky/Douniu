package packet.game.tv.value
{
	import packet.game.tv.TVValue;
	import flash.utils.ByteArray;

	public class RequestRobDealer extends TVValue
	{
		public var multiple:int;				// Byte(1)
				
		public function RequestRobDealer()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			bytes.writeByte(multiple);

			super.pack(bytes);
		}

		override public function unpack(bytes:ByteArray) : void
		{
			
		}
	}
}