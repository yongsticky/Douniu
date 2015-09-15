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
				
				// 这里不要destroy wrapper里面的单个packet,因为wrappermessage对象会在整个dispatchEvent结束后被destroy
			}
		}
		
		override protected function loadFakeRecvData(recvBuf:Vector.<ByteArray>) : void
		{
			/*
			var fakeBytes:ByteArray = new ByteArray();
			
			// 00 78 00 00 00 00 00 01 00 01 01 c9 c3 81 00 00
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x78);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0xc9);
			fakeBytes.writeByte(0xc3);
			fakeBytes.writeByte(0x81);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			
			// 3d c6 00 01 00 00 00 67 9e 01 00 00 00 00 00 5a
			fakeBytes.writeByte(0x3d);
			fakeBytes.writeByte(0xc6);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x67);
			fakeBytes.writeByte(0x9e);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x5a);
			
			// 00 02 00 27 3d c7 00 02 00 00 00 67 9e 01 00 00
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x02);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x27);
			fakeBytes.writeByte(0x3d);
			fakeBytes.writeByte(0xc7);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x02);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x67);
			fakeBytes.writeByte(0x9e);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			
			// 00 00 00 19 00 15 00 00 00 00 00 00 00 03 00 00			
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x19);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x15);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x03);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			
			// 00 00 01 00 00 01 4e 23 00 01 01 00 2b 3d c7 00
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x4e);
			fakeBytes.writeByte(0x23);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x2b);
			fakeBytes.writeByte(0x3d);
			fakeBytes.writeByte(0xc7);
			fakeBytes.writeByte(0x00);
			
			// 02 00 00 00 67 9e 01 00 00 00 00 00 1d 00 19 00
			fakeBytes.writeByte(0x02);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x67);
			fakeBytes.writeByte(0x9e);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x1d);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x19);
			fakeBytes.writeByte(0x00);
			
			// 00 00 00 00 00 00 04 00 00 00 00 00 03 01 03 05
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x04);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x03);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x03);
			fakeBytes.writeByte(0x05);
			
			// 00 01 4e 22 00 02 02 0a
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x01);
			fakeBytes.writeByte(0x4e);
			fakeBytes.writeByte(0x22);
			fakeBytes.writeByte(0x00);
			fakeBytes.writeByte(0x02);
			fakeBytes.writeByte(0x02);
			fakeBytes.writeByte(0x0a);		
			
			
			fakeBytes.position = 0;
			recvBuf.push(fakeBytes);
			*/
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