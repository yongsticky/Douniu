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
			opt = new ByteArray();
		}
		
		public function getLength() : int
		{
			return BASE_LENGTH + opt_len;
		}
		
		public function copy(header:CsHeader) : void
		{
			total_len = header.total_len;
			ver = header.ver;
			seq = header.seq;
			dialog_id = header.dialog_id;
			uin = header.uin;
			body_flag = header.body_flag;
			opt_len = header.opt_len;
			if (opt_len > 0)
			{				
				var p1:int = header.opt.position;
				
				opt.clear();
				opt.readBytes(header.opt, 0, opt_len);				
			}
			
		}
	}
}