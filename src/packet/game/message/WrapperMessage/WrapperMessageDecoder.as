package packet.game.message.WrapperMessage
{
	import flash.utils.ByteArray;
	
	import camu.design_pattern.Singleton;
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import factory.NiuObjectFactory;
	
	import packet.protocol.MsgHeader;
	import packet.protocol.NiuResponsePacket;
		

	public class WrapperMessageDecoder
	{
		private var _logger:ILogger;		
		
		public function WrapperMessageDecoder()
		{
			_logger = Logger.createLogger(WrapperMessageDecoder, LEVEL.DEBUG);			
		}
		
		public static function instance() : WrapperMessageDecoder
		{
			return Singleton.instanceOf(WrapperMessageDecoder);
		}

		public function decode(bytes:ByteArray, bytesLen:int) : NiuResponsePacket
		{	
			_logger.log("decode Enter", LEVEL.DEBUG);

			_logger.log("decode, bytes length=", bytesLen, LEVEL.DEBUG)
						
			var msgId:int = peekMsgId(bytes);			
			var responsePacket:NiuResponsePacket  = NiuObjectFactory.instance().createPacketInstance(msgId) as NiuResponsePacket;
			if (responsePacket)	
			{
				responsePacket.isWrapperedMessage = true;
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
				bytes.position -= 2;	
			}

			_logger.log("PeekMsgId, msgId:", msgId, LEVEL.INFO);

			return msgId;		
		}
	}
}