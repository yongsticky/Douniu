package packet.game.message.WrapperMessage
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
		
	import factory.NiuObjectFactory;	
	import packet.game.message.MSGID;
	import packet.protocol.MsgHeader;
	import packet.protocol.NiuResponsePacket;	
		

	public class WrapperMessageDecoder
	{
		protected var _logger:ILogger;		
		
		public function WrapperMessageDecoder(inner:PrivateInner)
		{
			_logger = Logger.createLogger(WrapperMessageDecoder, LEVEL.DEBUG);			
		}
		
		private static var _instance:WrapperMessageDecoder = null;
		public static function instance() : WrapperMessageDecoder
		{
			if (!_instance)
			{
				_instance = new WrapperMessageDecoder(new PrivateInner());
			}
			
			return _instance;
		}
		
		
		public function decode(bytes:ByteArray, bytesLen:int) : NiuResponsePacket
		{	
			_logger.log(this, "decode Enter", LEVEL.DEBUG);

			_logger.log(this, "decode, bytes length=", bytesLen, LEVEL.DEBUG)
						
			var msgId:int = peekMsgId(bytes);			
			var responsePacket:NiuResponsePacket  = NiuObjectFactory.instance().createInstance(MSGID.MSGID_TO_CLASS(msgId)) as NiuResponsePacket;
			if (responsePacket)	
			{
				responsePacket.isWrapperedMessage = true;
				responsePacket.unpack(bytes);
				
				responsePacket.printResponse(_logger);

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

			_logger.log(this, "PeekMsgId, msgId:", msgId, LEVEL.INFO);

			return msgId;		
		}
	}
}

class PrivateInner
{
	
}