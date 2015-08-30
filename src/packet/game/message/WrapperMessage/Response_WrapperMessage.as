package packet.game.message.WrapperMessage
{
	import flash.utils.ByteArray;
		
	import camu.net.Packet;
	
	import packet.protocol.NiuResponsePacket;
		

	public class Response_WrapperMessage extends NiuResponsePacket
	{		
		public var packet_num:int;								// short(2)
		public var packet_vec:Vector.<Packet>; 			// ?

		
		public function Response_WrapperMessage()
		{
			super();
			
			packet_vec = new Vector.<Packet>();
		}
		
		override public function unpackMsgParam(bytes:ByteArray):void
		{
			packet_num = bytes.readShort();
			
			if (packet_num > 0)
			{				
				for (var i:int = 0; i < packet_num; i++)
				{
					var msgLen:int = bytes.readShort();
					
					var _wrapperMessageDecoder:WrapperMessageDecoder = WrapperMessageDecoder.instance();
					var packet:Packet = _wrapperMessageDecoder.decode(bytes, msgLen);
					if (packet)
					{
						packet_vec.push(packet);
					}
				}
			}
		}		
	}
}