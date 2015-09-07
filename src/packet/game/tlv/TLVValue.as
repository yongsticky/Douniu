package packet.game.tlv
{
	import flash.utils.ByteArray;

	public class TLVValue
	{
		public var value_len:int;		
		
		public function TLVValue()
		{			
		}		
		
		public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(value_len);
			if (bytes.bytesAvailable < value_len-2)
			{
				throw new Error("TLVValue Length Error.");
			}
			
			//end_pos = bytes.position + value_len;
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < 2)			
			{
				throw new Error("TLVValue Length Error.");
			}
			
			value_len = bytes.readShort();			
			if (bytes.bytesAvailable < value_len - 2)
			{
				throw new Error("TLVValue Length Error.");
			}
			
			//end_pos = bytes.position + value_len;
		}
		
		protected function adjustPosition(bytes:ByteArray) : void
		{
			/*
			if (bytes.position <= end_pos)
			{
				bytes.position = end_pos;	
			}
			else
			{
				throw new Error("ByteArray position Overflow.");
			}
			*/
		}
		
		public function dispose() : void
		{
		}
		 
	}
}