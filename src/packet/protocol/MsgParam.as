package packet.protocol
{
	import flash.utils.ByteArray;	

	public class MsgParam
	{
		public var param_len:uint;
		public var param_bytes:ByteArray;
		
		private const BASE_LENGTH:int = 4;
		
		public function MsgParam()
		{
		}
		
		public function getLength() : int
		{
			return BASE_LENGTH + param_len;
		}
	}
}