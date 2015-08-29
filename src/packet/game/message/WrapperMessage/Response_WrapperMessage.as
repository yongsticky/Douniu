package packet.game.message.WrapperMessage
{
	import flash.utils.ByteArray;
	
	import camu.design_pattern.Singleton;
	import camu.net.Packet;
	
	import packet.protocol.NiuResponsePacket;
	
	import server.NiuServerConnection;

	public class Response_WrapperMessage extends NiuResponsePacket
	{		
		public var _msgNum:int;		

		
		public function Response_WrapperMessage()
		{
			super();
		}
		
		public function unpackWrapperMessage(bytes:ByteArray) : Boolean
		{
			unpackMsgHeader(bytes);
			
			if (_isOK)
			{				
				if (bytes.bytesAvailable < _msgHeader.param_len - 2)
				{
					_isOK = false;
				}				
				else
				{
					unpackMsgParam(bytes);	
				}
			}
			
			return _isOK;
		}

		
		override public function unpackMsgParam(bytes:ByteArray):void
		{
			_msgNum = bytes.readShort();
			
			for (var i:int = 0; i < _msgNum; i++)
			{
				var msgLen:int = bytes.readShort();
				
				var _wrapperMessageDecoder:WrapperMessageDecoder = Singleton.instanceOf(WrapperMessageDecoder);
				var packet:Packet = _wrapperMessageDecoder.decode(bytes, msgLen);
				if (packet)
				{
					var connector:NiuServerConnection = Singleton.instanceOf(NiuServerConnection);
					connector.dispatchWarpperMessagePacket(packet as NiuResponsePacket);					
				}
			}
		}
		
		
	}
}