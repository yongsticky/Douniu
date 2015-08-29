package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class TLVValue
	{
		public var value_len:int;
		
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
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			value_len = bytes.readShort();
		}
		 
	}
}