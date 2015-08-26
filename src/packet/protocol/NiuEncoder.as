package packet.protocol
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import camu.net.IEncoder;
	import camu.net.Packet;
	import camu.util.log.ILogger;
	import camu.util.log.LogLevel;
	import camu.util.log.Logger;
	
	import packet.NiuPacketFactory;
	import camu.util.Bytes2Hex;
	import camu.util.ShortIntUtil;
	
	

	public class NiuEncoder implements IEncoder// implements IObjectFactory
	{
		private var _logger:ILogger;
		
		private var _packetFactory:NiuPacketFactory = null;
		
		public function NiuEncoder(packetFactory:NiuPacketFactory)
		{
			_logger = Logger.createLogger(NiuEncoder, LogLevel.DEBUG);
			
			_packetFactory = packetFactory;
		}	
		
		public function encode(packet:Packet) : ByteArray
		{
			_logger.log("encode Enter", LogLevel.DEBUG);
			
			var niuPacket:NiuPacket = packet as NiuPacket;
			if (niuPacket)
			{
				var csh:CSHeader = niuPacket.csHeader;
				var msgh:MsgHeader = niuPacket.msgHeader;
				var msgp:MsgParam = niuPacket.msgParam;
								
				csh.total_len = msgp.getLength() + msgh.getLength() + csh.getLength();
								
				//var bytes:ByteArray = new ByteArray();
				var bytes:ByteArray = _packetFactory.createInstance(ByteArray);
				bytes.endian = Endian.BIG_ENDIAN;
				bytes.length = csh.total_len;
				bytes.position = 0;				
				
				// CSHeader
				//bytes.writeUnsignedInt(csh.total_len);
				ShortIntUtil.writeShortInt(bytes, csh.total_len);
				//bytes.writeUnsignedInt(csh.ver);
				ShortIntUtil.writeShortInt(bytes, csh.ver);				
				//bytes.writeUnsignedInt(csh.seq);
				ShortIntUtil.writeShortInt(bytes, csh.seq);				
				bytes.writeInt(csh.dialog_id);
				bytes.writeUnsignedInt(csh.uin);
				bytes.writeByte(csh.body_flag);
				bytes.writeByte(csh.opt_len);
				if (csh.opt_len > 0)
				{
					bytes.writeBytes(csh.opt, csh.opt_len);
				}
								
				// MsgHeader
				//bytes.writeInt(msgh.msg_id);
				ShortIntUtil.writeShortInt(bytes, msgh.msg_id);
				//bytes.writeInt(msgh.msg_type);
				ShortIntUtil.writeShortInt(bytes, msgh.msg_type);				
				bytes.writeInt(msgh.msg_seq);
				bytes.writeByte(msgh.src_fe);
				bytes.writeByte(msgh.dest_fe);				
				//bytes.writeInt(msgh.src_id);
				ShortIntUtil.writeShortInt(bytes, msgh.src_id);
				//bytes.writeInt(msgh.dest_id);
				ShortIntUtil.writeShortInt(bytes, msgh.dest_id);
				
				
				// MsgParam
				bytes.writeUnsignedInt(msgp.param_len);
				if (msgp.param_len > 0)
				{
					bytes.writeBytes(msgp.param_bytes, msgp.param_len);
				}
				
				bytes.position = 0;
				_logger.log("after encode, length=", bytes.bytesAvailable, LogLevel.DEBUG);				
				
				Bytes2Hex.Trace(bytes);
				
				return bytes;
			}
			
			return null;
		}
	}
}