package packet.game.message.WrapperMessage
{
	import flash.utils.ByteArray;
	
	import camu.net.Packet;
	
	import factory.NiuObjectFactory;
		
	import packet.protocol.NiuResponsePacket;
		

	public class Response_WrapperMessage extends NiuResponsePacket
	{		
		public var packet_num:int;								// short(2)
		public var packet_vec:Vector.<NiuResponsePacket>;		// ?

		
		public function Response_WrapperMessage()
		{
			super();
			
			packet_vec = new Vector.<NiuResponsePacket>();
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
					var responsePacket:Packet = _wrapperMessageDecoder.decode(bytes, msgLen);
					if (responsePacket)
					{
						packet_vec.push(responsePacket);
					}
				}
			}
		}
		
		override public function dispose() : void
		{
			super.dispose();
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:NiuResponsePacket in packet_vec)
			{
				item.dispose();
				_factory.destroyInstance(item);
			}
			
			packet_num = 0;
			packet_vec.length = 0;
		}
	}
}