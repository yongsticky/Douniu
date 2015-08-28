package server
{
	import flash.utils.ByteArray;
	
	import camu.net.BaseConnection;
	import camu.net.Packet;
	import camu.net.PacketEvent;
	import camu.net.PacketEventCreator;
	
	import packet.NiuDecoder;
	import packet.NiuEncoder;
	import packet.NiuPacketFactory;
	import packet.protocol.NiuResponsePacket;
	
	public final class NiuServerConnection extends BaseConnection
	{
		private var _encoder:NiuEncoder;
		private var _decoder:NiuDecoder;
		
		private var _packetFactory:NiuPacketFactory;
		
		
		public function NiuServerConnection()
		{
			super();			
			
			_packetFactory = new NiuPacketFactory();			
			
			_encoder = new NiuEncoder(_packetFactory);
			_decoder = new NiuDecoder(_packetFactory);
									
		}
		
		public function dispatchWarpperMessagePacket(packet:NiuResponsePacket) : void
		{
			if (packet)
			{
				dispatchPacketEvent(packet);
				
				deleteObject(packet);
			}
		}
		
		override public function encode(packet:Packet) : ByteArray
		{
			return _encoder.encode(packet);			
		}
		
		override public function decode(bytes:ByteArray) : Packet
		{
			return _decoder.decode(bytes);
		}
		
		override public function newObject(cls:Class, data:* = null): *
		{			
			return _packetFactory.createInstance(cls, data)
		}
		
		override public function deleteObject(obj:*) : void
		{			
			_packetFactory.destroyInstance(obj);
		}
		
		override public function getPacketHeaderLength() : int
		{
			return 2;
		}
		
		override public function resolvePacketBodyLength(bytes:ByteArray) : int
		{
			var backupPos:uint = bytes.position;
			
			
			bytes.position = 0;
			var bodyLen:int = bytes.readShort() - 2;	// 要除去包头
			
			bytes.position = backupPos;
			
			return bodyLen;
		}
	}
}