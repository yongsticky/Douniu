package packet.protocol
{
	import flash.utils.ByteArray;
	
	import camu.net.IDecoder;
	import camu.net.Packet;
	
	import packet.NiuPacketFactory;
	import packet.util.ShortIntUtil;

	public class NiuDecoder implements IDecoder
	{
		private var _packetFactory:NiuPacketFactory = null;
		
		public function NiuDecoder(packetFactory:NiuPacketFactory)
		{ 
			_packetFactory = packetFactory;
		}		
		
		public function decode(bytes:ByteArray) : Packet
		{
			var msgId:int = peekMsgId(bytes);
			var newPacket:Packet = _packetFactory.createPacketInstance(msgId);
			
			return newPacket;
		}
		
		private function peekMsgId(bytes:ByteArray) : int
		{
			var backupPos:uint = bytes.position;
			var msgId:int = -1;
			
			if (bytes.bytesAvailable > CSHeader.BASE_LENGTH)
			{
				bytes.position = CSHeader.BASE_LENGTH-1;
				var optLen:int = bytes.readByte();
				if (bytes.bytesAvailable > optLen+2)
				{
					bytes.position = CSHeader.BASE_LENGTH + optLen;
					
					msgId = ShortIntUtil.readShortInt(bytes);
				}				
			}
		
			bytes.position = backupPos;
			
			return msgId;
		}
	}
}