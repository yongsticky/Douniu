package server
{
	import flash.utils.ByteArray;
	
	import camu.net.BaseConnection;
	import camu.net.Packet;
	import camu.net.PacketEvent;
	import camu.net.PacketEventCreator;
	import camu.util.ShortIntUtil;
	
	import packet.NiuPacketFactory;
	import packet.protocol.NiuDecoder;
	import packet.protocol.NiuEncoder;
	
	public final class NiuServerConnection extends BaseConnection
	{
		private var _encoder:NiuEncoder;
		private var _decoder:NiuDecoder;
		
		private var _packetFactory:NiuPacketFactory;
		
		public function NiuServerConnection()
		{
			super();
			
			_packetFactory = new NiuPacketFactory();
			
			_packetFactory.registerClass(PacketEvent, new PacketEventCreator());
			
			_encoder = new NiuEncoder(_packetFactory);
			_decoder = new NiuDecoder(_packetFactory);			
									
		}
		
		override public function encode(packet:Packet) : ByteArray
		{
			return _encoder.encode(packet);			
		}
		
		override public function decode(bytes:ByteArray) : Packet
		{
			return _decoder.decode(bytes);
		}
		
		override public function newObject(cls:Class, ...args): *
		{
			if (args.length == 0)
			{
				return _packetFactory.createInstance(cls)
			}
			else
			{
				return _packetFactory.createInstance(cls, args);
			}
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
			var bodyLen:int = ShortIntUtil.readShortInt(bytes) - 2;		// 要除去包头
			
			bytes.position = backupPos;
			
			return bodyLen;
		}
	}
}