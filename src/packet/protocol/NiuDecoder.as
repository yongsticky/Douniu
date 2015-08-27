package packet.protocol
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;	
	import camu.net.Packet;
	import camu.util.Bytes2Hex;
	import camu.util.ShortIntUtil;
	
	import packet.NiuPacketFactory;

	public class NiuDecoder
	{
		private var _packetFactory:NiuPacketFactory = null;
		
		private var _logger:ILogger;
		
		public function NiuDecoder(packetFactory:NiuPacketFactory)
		{ 
			_packetFactory = packetFactory;
			
			_logger = Logger.createLogger(NiuDecoder, LEVEL.DEBUG);
		}		
		
		public function decode(bytes:ByteArray) : Packet
		{
			_logger.log("decode Enter, bytes.length=", bytes.length, LEVEL.DEBUG);
			Bytes2Hex.Trace(bytes);
			
			var msgId:int = peekMsgId(bytes);
			
			_logger.log("decode, PeekMsgId return:", msgId.toString(), LEVEL.INFO);
			
			var newPacket:Packet = _packetFactory.createPacketInstance(msgId);
			
			return newPacket;
		}
		
		private function peekMsgId(bytes:ByteArray) : int
		{		
			var backupPos:uint = bytes.position;
			bytes.position = 0;
			
			var msgId:int = -1;
			
			if (bytes.bytesAvailable > CsHeader.BASE_LENGTH)
			{
				bytes.position = CsHeader.BASE_LENGTH-1;
				var optLen:uint = bytes.readByte();				
				if (bytes.bytesAvailable > optLen+2)
				{
					bytes.position = CsHeader.BASE_LENGTH + optLen;
					
					msgId = ShortIntUtil.readShortInt(bytes);
				}				
			}
		
			bytes.position = backupPos;
			
			return msgId;
		}
	}
}