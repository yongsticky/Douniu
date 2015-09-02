package server
{
	import camu.singleton.Singleton;
	import camu.logger.ILogger;
	import camu.logger.Logger;
	import camu.logger.LEVEL;
	
	import packet.protocol.NiuRequestPacket;

	public class NiuServerRequestSender
	{
		private var _logger:ILogger;
		
		public function NiuServerRequestSender()
		{
			_logger = Logger.createLogger(NiuServerRequestSender, LEVEL.INFO);
		}
		
		public static function instance() : NiuServerRequestSender
		{
			return Singleton.instanceOf(NiuServerRequestSender);
		}
		
		public function sendRequest(requestPacket:NiuRequestPacket) : void
		{
			if (requestPacket)
			{
				_logger.log("sendRequest,msgId=", requestPacket.msgHeader.msg_id, LEVEL.INFO);				
				NiuServerConnector.instance().send(requestPacket);
			}
			else
			{
				throw new Error("null packet!");
			}
		}
	}
}