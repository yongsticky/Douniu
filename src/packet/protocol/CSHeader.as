package packet.protocol
{
	import flash.utils.ByteArray;

	public class CsHeader
	{		
		public var total_len:int;		// short(2)
		public var ver:int;			// short(2)
		public var seq:int;			// short(2)
		public var dialog_id:int;		// int(4)
		public var uin:uint;			// unsigned int(4)
		public var body_flag:uint;		// unsigned char(1)
		public var opt_len:uint;		// unsigned char(1)
		public var opt:ByteArray;		// unsigned char[]
		
		public static const BASE_LENGTH:int = 16;
		
		public function CsHeader()
		{			
		}
		
		public function getLength() : int
		{
			return BASE_LENGTH + opt_len;
		}
	}
}