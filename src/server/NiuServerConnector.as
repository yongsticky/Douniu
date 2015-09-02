package server
{
	import flash.utils.ByteArray;
	
	import camu.singleton.Singleton;
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.BaseConnector;
	import camu.net.Packet;
	
	import factory.NiuObjectFactory;
	
	import packet.NiuDecoder;
	import packet.NiuEncoder;
	import packet.protocol.NiuResponsePacket;
	
	public final class NiuServerConnector extends BaseConnector
	{
		private var _logger:ILogger;
		
		private var _encoder:NiuEncoder;
		private var _decoder:NiuDecoder;		
		
		public function NiuServerConnector()
		{
			super();
			
			_logger = Logger.createLogger(NiuServerConnector, LEVEL.INFO);
			
			_encoder = new NiuEncoder();
			_decoder = new NiuDecoder();
									
		}
		
		public static function instance() : NiuServerConnector
		{
			return Singleton.instanceOf(NiuServerConnector);
		}
		
		public function dispatchWarpperMessagePacket(responsePacket:NiuResponsePacket) : void
		{
			_logger.log("dispatchWarpperMessagePacket, eventType=", responsePacket.eventType);
			
			if (responsePacket)
			{
				dispatchPacketEvent(responsePacket);
				
				deleteObject(responsePacket);
			}
		}
		
		override protected function encode(packet:Packet) : ByteArray
		{
			return _encoder.encode(packet);			
		}
		
		override protected function decode(bytes:ByteArray) : Packet
		{
			return _decoder.decode(bytes);
		}
		
		override protected function newObject(cls:Class, data:* = null): *
		{			
			return NiuObjectFactory.instance().createInstance(cls, data)
		}
		
		override protected function deleteObject(obj:*) : void
		{			
			NiuObjectFactory.instance().destroyInstance(obj);
		}
		
		override protected function getPacketHeaderLength() : int
		{
			return 2;
		}
		
		override protected function resolvePacketBodyLength(bytes:ByteArray) : int
		{
			var backupPos:uint = bytes.position;
			
			
			bytes.position = 0;
			var bodyLen:int = bytes.readShort() - 2;	// 要除去包头
			
			bytes.position = backupPos;
			
			return bodyLen;
		}
	}
}