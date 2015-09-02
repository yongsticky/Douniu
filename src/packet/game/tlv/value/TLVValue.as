package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class TLVValue
	{
		public var value_len:int;
		
		protected var end_pos:int;
		
		protected var _isOK:Boolean;
		
		public function TLVValue()
		{
			_isOK = true;
		}
		
		public function get isOK() : Boolean
		{
			return _isOK;
		}
		
		public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(value_len);
			
			end_pos = bytes.position + value_len;
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			value_len = bytes.readShort();
			
			end_pos = bytes.position + value_len;
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