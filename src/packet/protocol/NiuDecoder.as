package packet.protocol
{
	import flash.utils.ByteArray;
	
	import camu.net.IDecoder;
	import camu.net.Packet;
	
	import packet.NiuPacketFactory;

	public class NiuDecoder implements IDecoder
	{
		private var _packetFactory:NiuPacketFactory = null;
		
		public function NiuDecoder(packetFactory:NiuPacketFactory)
		{ 
			_packetFactory = packetFactory;
		}		
		
		public function decode(bytes:ByteArray) : Packet
		{
			return null;
		}
	}
}