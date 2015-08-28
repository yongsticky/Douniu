package packet
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.Packet;
	import camu.util.Bytes2Hex;
	
	import packet.game.WrapperMessage.Response_WrapperMessage;
	import packet.game.WrapperMessage.WrapperMessageDecoder;
	import packet.protocol.CsHeader;
	import packet.protocol.NiuResponsePacket;

	public class NiuDecoder
	{
		private var _logger:ILogger;

		private var _packetFactory:NiuPacketFactory;
		private var _wrapperMessageDecoder:WrapperMessageDecoder;		
		
		public function NiuDecoder(factory:NiuPacketFactory)
		{ 		
			_logger = Logger.createLogger(NiuDecoder, LEVEL.DEBUG);
			
			_packetFactory = factory;
			_wrapperMessageDecoder = new WrapperMessageDecoder(_packetFactory);
		}
		
		public function decode(bytes:ByteArray) : Packet
		{			
			_logger.log("decode Enter, bytes.length=", bytes.length, LEVEL.DEBUG);
			Bytes2Hex.Trace(bytes);
			
			var msgId:int = peekMsgId(bytes);			
			var responsePacket:NiuResponsePacket  = _packetFactory.createPacketInstance(msgId) as NiuResponsePacket;
			if (responsePacket is Response_WrapperMessage)
			{
				(responsePacket as Response_WrapperMessage).wrapperDecoder = _wrapperMessageDecoder;
			}
						
			if (!responsePacket.unpack(bytes))
			{
				_packetFactory.destroyInstance(responsePacket);
				responsePacket = null;
			}			

			return responsePacket;
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