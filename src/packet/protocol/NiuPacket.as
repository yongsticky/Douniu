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
	}
}