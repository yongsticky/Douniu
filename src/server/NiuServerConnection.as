package server
{
	import flash.utils.ByteArray;
	
	import camu.design_pattern.Singleton;
	import camu.net.BaseConnection;
	import camu.net.Packet;
	
	import factory.NiuObjectFactory;
	
	import packet.NiuDecoder;
	import packet.NiuEncoder;
	import packet.protocol.NiuResponsePacket;
	
	public final class NiuServerConnection extends BaseConnection
	{
		private var _encoder:NiuEncoder;
		private var _decoder:NiuDecoder;		
		
		public function NiuServerConnection()
		{
			super();	
			
			_encoder = new NiuEncoder();
			_decoder = new NiuDecoder();
									
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
			var _factory:NiuObjectFactory = Singleton.instanceOf(NiuObjectFactory);
			return _factory.createInstance(cls, data)
		}
		
		override public function deleteObject(obj:*) : void
		{
			var _factory:NiuObjectFactory = Singleton.instanceOf(NiuObjectFactory);
			_factory.destroyInstance(obj);
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