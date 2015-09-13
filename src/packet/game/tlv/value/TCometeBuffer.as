package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;

	public class TCometeBuffer extends TLVValue
	{
		public var computer_buffer_len:int;			// short(2)
		public var computer_buffer:ByteArray;				// char[]
		
		public function TCometeBuffer()
		{
			super();
			
			computer_buffer = new ByteArray();
		}
		
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeShort(computer_buffer_len);
			if (computer_buffer_len > 0)
			{
				bytes.writeBytes(computer_buffer, 0, computer_buffer_len);
			}			
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			computer_buffer_len = bytes.readShort();
			if (computer_buffer_len > 0)
			{
				bytes.readBytes(computer_buffer, 0, computer_buffer_len);
			}			
			
			super.adjustPosition(bytes);
		}
		
		override public function onObjectRecycled() : void
		{
			computer_buffer.clear();
			computer_buffer_len = 0;
		}
	}
}