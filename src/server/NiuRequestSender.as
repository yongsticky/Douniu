package server
{
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import packet.protocol.NiuRequestPacket;

	public class NiuRequestSender
	{
		protected var _logger:ILogger;
		
		public function NiuRequestSender(inner:PrivateInner)
		{
			_logger = Logger.createLogger(NiuRequestSender, LEVEL.INFO);
		}
		
		private static var _instance:NiuRequestSender = null;
		public static function instance() : NiuRequestSender
		{
			if (!_instance)
			{
				_instance = new NiuRequestSender(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function sendRequest(requestPacket:NiuRequestPacket) : void
		{
			if (requestPacket)
			{
				_logger.log(this, "sendRequest,msgId=", requestPacket.msgHeader.msg_id, LEVEL.INFO);				
				NiuServerConnector.instance().send(requestPacket);
			}
			else
			{
				throw new Error("null packet!");
			}
		}
	}
}

class PrivateInner
{
	
}