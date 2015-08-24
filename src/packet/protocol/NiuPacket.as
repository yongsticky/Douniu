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
	}
}