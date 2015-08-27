package packet.protocol
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.Packet;
	import camu.util.Bytes2Hex;
	
	import packet.NiuPacketFactory;
	
	

	public class NiuEncoder
	{
		private var _logger:ILogger;
		
		private var _packetFactory:NiuPacketFactory = null;
		
		public function NiuEncoder(packetFactory:NiuPacketFactory)
		{
			_logger = Logger.createLogger(NiuEncoder, LEVEL.DEBUG);
			
			_packetFactory = packetFactory;
		}	
		
		public function encode(packet:Packet) : ByteArray
		{
			_logger.log("encode Enter", LEVEL.DEBUG);
			
			var niuPacket:NiuPacket = packet as NiuPacket;
			if (niuPacket)
			{
				var bytes:ByteArray = _packetFactory.createInstance(ByteArray);
				
				bytes.endian = Endian.BIG_ENDIAN;

				niuPacket.pack(bytes);
				
				_logger.log("encode, pack length=", bytes.length, LEVEL.DEBUG);
				Bytes2Hex.Trace(bytes);
				
				bytes.position = 0;
				return bytes;
			}
			
			return null;
		}
	}
}