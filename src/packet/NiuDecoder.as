package packet
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.Packet;
	import camu.util.Bytes2Hex;
	
	import factory.NiuObjectFactory;	
	import packet.game.message.MSGID;
	import packet.protocol.CsHeader;
	import packet.protocol.NiuResponsePacket;

	public class NiuDecoder
	{
		private var _logger:ILogger;
		
		public function NiuDecoder()
		{ 		
			_logger = Logger.createLogger(NiuDecoder, LEVEL.DEBUG);
		}
		
		public function decode(bytes:ByteArray) : Packet
		{			
			_logger.log("decode Enter, bytes.length=", bytes.length, LEVEL.DEBUG);
			Bytes2Hex.Trace(bytes);			
			
			var msgId:int = peekMsgId(bytes);		
			var responsePacket:NiuResponsePacket  = NiuObjectFactory.instance().createInstance(MSGID.MSGID_TO_CLASS(msgId)) as NiuResponsePacket;
			if (responsePacket)
			{
				responsePacket.unpack(bytes);	
				
				responsePacket.printResponse(_logger);
				
				return responsePacket;
			}
			else
			{
				throw new Error("Not ResponsePacket Class.");
			}			
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
					msgId = bytes.readShort();
				}				
			}
		
			bytes.position = backupPos;

			_logger.log("PeekMsgId, msgId:", msgId, LEVEL.INFO);
			
			return msgId;
		}
	}
}