package packet.game.WrapperMessage
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.Packet;
	
	import packet.NiuPacketFactory;
	import packet.protocol.MsgHeader;
	import packet.protocol.NiuResponsePacket;
		

	public class WrapperMessageDecoder
	{
		private var _logger:ILogger;
		
		private var _packetFactory:NiuPacketFactory;
		
		public function WrapperMessageDecoder(factory:NiuPacketFactory)
		{
			_logger = Logger.createLogger(WrapperMessageDecoder, LEVEL.DEBUG);
			
			_packetFactory = factory;
		}

		public function decode(bytes:ByteArray, bytesLen:int) : Packet
		{	
			_logger.log("decode Enter", LEVEL.DEBUG);

			_logger.log("decode, bytes length=", bytesLen, LEVEL.DEBUG)
			
			var msgId:int = peekMsgId(bytes);			
			var responsePacket:NiuResponsePacket  = _packetFactory.createPacketInstance(msgId) as NiuResponsePacket;
			if (responsePacket)	
			{
				responsePacket.isInWrapperMessage = true;			
				responsePacket.unpack(bytes);

				return responsePacket;
			}

			return null;
		}
		
		private function peekMsgId(bytes:ByteArray) : int
		{
			var msgId:int = -1;
			if (bytes.bytesAvailable >= MsgHeader.BASE_LENGTH)			
			{
				msgId = bytes.readShort();
			}

			_logger.log("PeekMsgId, msgId:", msgId, LEVEL.INFO);

			return msgId;		
		}
	}
}