package packet.protocol
{
	import camu.net.Packet;
	
	
	public class NiuPacket extends Packet
	{
		protected var _csHeader:CSHeader;
		protected var _msgHeader:MsgHeader;
		protected var _msgParam:MsgParam;
		
		
		public function NiuPacket()
		{
			super();
			
			_csHeader = new CSHeader();
			_msgHeader = new MsgHeader();
			_msgParam = new MsgParam();
		}		
		
		public function get csHeader() : CSHeader
		{
			return _csHeader;
		}
		
		public function get msgHeader() : MsgHeader
		{
			return _msgHeader;
		}
		
		public function get msgParam() : MsgParam
		{
			return _msgParam;
		}
		
		public function initCSHeader() : void
		{
			_csHeader.ver = 0;
			_csHeader.dialog_id = -1;
			_csHeader.opt_len = 0;
			_csHeader.body_flag = 0;			
			_csHeader.seq = SeqUtil.getNextSeq();		
		}
		
		public function initMsgHeader() : void
		{			
			_msgHeader.msg_type = 0;
			_msgHeader.msg_seq = SeqUtil.getNextSeq();
			_msgHeader.src_fe = 1;
			_msgHeader.dest_fe = 158;	
			_msgHeader.src_id = 0;
			_msgHeader.dest_id = 0;
		}
		
		public function packMsgParam() : void
		{
			throw new Error("Abstract function!");
		}
	}
}