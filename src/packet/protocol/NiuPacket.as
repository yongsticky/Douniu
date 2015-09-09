package packet.protocol
{
	import camu.net.Packet;
	import camu.object.interfaces.IObjectRecycled;
	
	public class NiuPacket extends Packet implements IObjectRecycled
	{
		protected var _csHeader:CsHeader;
		protected var _msgHeader:MsgHeader;
		
		public function NiuPacket()
		{
			super();
			
			_csHeader = new CsHeader();
			_msgHeader = new MsgHeader();
		}
		
		protected function initData() : void
		{
			throw new Error("Abstract function, you must override it.");
		}
	
		public function onObjectRecycled() : void
		{
			
		}
		
		public function get csHeader() : CsHeader
		{
			return _csHeader;
		}
		
		public function get msgHeader() : MsgHeader
		{
			return _msgHeader;
		}	
		
		protected function deafualtCsHeader() : void
		{
			_csHeader.ver = 0;
			_csHeader.dialog_id = -1;
			_csHeader.opt_len = 0;
			_csHeader.body_flag = 0;			
			_csHeader.seq = SeqUtil.getNextSeq();		
		}
		
		protected function defaultMsgHeader() : void
		{			
			_msgHeader.msg_type = 0;
			_msgHeader.msg_seq = SeqUtil.getNextSeq();
			_msgHeader.src_fe = 1;
			_msgHeader.dest_fe = 158;	
			_msgHeader.src_id = 0;
			_msgHeader.dest_id = 0;
		}
		
		
	}
}