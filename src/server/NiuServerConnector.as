package server
{
	import flash.utils.ByteArray;
	
	import camu.logger.LEVEL;	
	import camu.net.Connector;
	import camu.net.Packet;	
	import factory.NiuObjectFactory;	
	import packet.NiuDecoder;
	import packet.NiuEncoder;
	import packet.protocol.NiuResponsePacket;
	
	public final class NiuServerConnector extends Connector
	{		
		private var _encoder:NiuEncoder;
		private var _decoder:NiuDecoder;		
		
		public function NiuServerConnector(inner:PrivateInner)
		{
			super();	
			
			_encoder = new NiuEncoder();
			_decoder = new NiuDecoder();
									
		}
		
		private static var _instance:NiuServerConnector = null;
		public static function instance() : NiuServerConnector
		{
			if (!_instance)
			{
				_instance = new NiuServerConnector(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function dispatchWarpperMessagePacket(responsePacket:NiuResponsePacket) : void
		{
			_logger.log(this, "dispatchWarpperMessagePacket, eventType=", responsePacket.eventType, LEVEL.INFO);
			
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
			return NiuObjectFactory.instance().createInstance(cls)
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

class PrivateInner
{
	
}