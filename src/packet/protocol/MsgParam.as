package packet.protocol
{
	import flash.utils.ByteArray;	

	public class MsgParam
	{
		public var param_len:int;
		public var param_bytes:ByteArray;
		
		public static const BASE_LENGTH:int = 2;	// short(2)
		
		public function MsgParam()
		{
		}
		
		public function getLength() : int
		{
			return BASE_LENGTH + param_len;
		}
	}
}