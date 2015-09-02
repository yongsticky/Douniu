package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class TCompeteBuffer extends TLVValue
	{
		public var computer_buffer_len:int;			// short(2)
		public var computer_buffer:String;				// char[]
		
		public function TCompeteBuffer()
		{
			super();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeShort(computer_buffer_len);
			if (computer_buffer_len > 0)
			{
				bytes.writeUTFBytes(computer_buffer);
			}			
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			computer_buffer_len = bytes.readShort();
			if (computer_buffer_len > 0)
			{
				computer_buffer = bytes.readUTFBytes(computer_buffer_len);
			}			
			
			super.adjustPosition(bytes);
		}
	}
}