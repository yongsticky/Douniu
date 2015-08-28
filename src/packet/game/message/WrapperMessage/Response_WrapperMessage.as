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
		
		private var _wrapperDecoder:WrapperMessageDecoder;
		
		public function Response_WrapperMessage()
		{
			super();			
		}
		
		public function set wrapperDecoder(decoder:WrapperMessageDecoder) : void
		{
			_wrapperDecoder = decoder;
		}		
		
		override public function unpackMsgParam(bytes:ByteArray):void
		{
			_msgNum = bytes.readShort();
			
			for (var i:int = 0; i < _msgNum; i++)
			{
				var msgLen:int = bytes.readShort();
				
				var packet:Packet = _wrapperDecoder.decode(bytes, msgLen);
				if (packet)
				{
					var connector:NiuServerConnection = Singleton.instanceOf(NiuServerConnection);
					connector.dispatchWarpperMessagePacket(packet as NiuResponsePacket);					
				}
			}
		}
		
		
	}
}