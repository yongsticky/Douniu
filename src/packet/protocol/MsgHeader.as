package packet.protocol
{
	public class MsgHeader
	{
		public var msg_id:int;		// short(2)
		public var msg_type:int;	// short(2)
		public var msg_seq:int;	// int(4)
		public var src_fe:uint;	// unsigned char(1)
		public var dest_fe:uint;	// unsigned char(1)
		public var src_id:int;		// short(2)
		public var dest_id:int;	// short(2)
		
		
		private const BASE_LENGTH:int = 14;
		
		public function MsgHeader()
		{			;
		}
		
		public function getLength() : int
		{
			return BASE_LENGTH; 
		}
		
		
	}
}