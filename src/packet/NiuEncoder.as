package packet
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
		
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.Packet;
	import camu.util.Bytes2Hex;
	
	import packet.protocol.NiuRequestPacket;
	
	

	public class NiuEncoder
	{
		private var _logger:ILogger;
		
		private var _packetFactory:NiuPacketFactory;
		
		public function NiuEncoder(factory:NiuPacketFactory)
		{
			_logger = Logger.createLogger(NiuEncoder, LEVEL.DEBUG);
			
			_packetFactory = factory;
		}	
		
		public function encode(packet:Packet) : ByteArray
		{
			_logger.log("encode Enter", LEVEL.DEBUG);
			
			var niuPacket:NiuRequestPacket = packet as NiuRequestPacket;
			if (niuPacket)
			{
				var bytes:ByteArray = _packetFactory.createInstance(ByteArray);
				
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