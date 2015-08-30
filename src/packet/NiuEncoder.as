package packet
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
		
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.Packet;
	import camu.util.Bytes2Hex;
	
	import factory.NiuObjectFactory;	
	import packet.protocol.NiuRequestPacket;
	
	

	public class NiuEncoder
	{
		private var _logger:ILogger;
		
		public function NiuEncoder()
		{
			_logger = Logger.createLogger(NiuEncoder, LEVEL.DEBUG);
		}	
		
		public function encode(packet:Packet) : ByteArray
		{
			_logger.log("encode Enter", LEVEL.DEBUG);
			
			var niuPacket:NiuRequestPacket = packet as NiuRequestPacket;
			if (niuPacket)
			{				
				var bytes:ByteArray = NiuObjectFactory.instance().createInstance(ByteArray);
				
				bytes.clear();
				bytes.endian = Endian.BIG_ENDIAN;

				niuPacket.pack(bytes);
				
				_logger.log("encode, pack length=", bytes.length, LEVEL.DEBUG);
				Bytes2Hex.Trace(bytes);				
				
				return bytes;
			}
			
			return null;
		}
	}
}