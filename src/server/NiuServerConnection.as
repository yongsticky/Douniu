package server
{
	import flash.utils.ByteArray;
	
	import camu.net.BaseConnection;
	import camu.net.Packet;
	
	import packet.protocol.NiuDecoder;
	import packet.protocol.NiuEncoder;
	import packet.NiuPacketFactory;	
	
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
		
		override public function encode(packet:Packet) : ByteArray
		{
			return _encoder.encode(packet);			
		}
		
		override public function decode(bytes:ByteArray) : Packet
		{
			return _decoder.decode(bytes);
		}
		
		override public function objectNew(cls:Class, ...args) : *
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
		
		override public function objectDelete(obj:*) : void
		{
			_packetFactory.destroyInstance(obj);
		}
	}
}