package packet.protocol
{
	import flash.utils.ByteArray;
	
	import camu.errors.AbstractFunctionError;
	
	
	public class NiuRequestPacket extends NiuPacket
	{		
		public function NiuRequestPacket()
		{
			super();
			
			deafualtCsHeader();
			defaultMsgHeader();
			
			initData();
		}				

		public function pack(bytes:ByteArray) : void
		{
			// 先pack msgparam的数据段，这里会调用具体实现类function
			bytes.position = _csHeader.getLength() + _msgHeader.getLength();
			var posBefore:int = bytes.position;
			packMsgParam(bytes);
			var posAfter:int = bytes.position;

			// 回填msgparam数据长度段
			_msgHeader.param_len = posAfter-posBefore;	

			// pack msgheader
			bytes.position = _csHeader.getLength();
			packMsgHeader(bytes);
			
			// pack csheader
			_csHeader.total_len = _csHeader.getLength() + _msgHeader.getLength() + _msgHeader.param_len;
			bytes.position = 0;
			packCSHeader(bytes);
			
			// 输出前复位到0
			bytes.position = 0;
		}
		
		public function packCSHeader(bytes:ByteArray) : void
		{						
			bytes.writeShort(_csHeader.total_len);			
			bytes.writeShort(_csHeader.ver);			
			bytes.writeShort(_csHeader.seq);
			bytes.writeInt(_csHeader.dialog_id);
			bytes.writeUnsignedInt(_csHeader.uin);
			bytes.writeByte(_csHeader.body_flag);
			bytes.writeByte(_csHeader.opt_len);
			if (_csHeader.opt_len > 0)
			{
				bytes.writeBytes(_csHeader.opt, _csHeader.opt_len);							
			}			
		}
		
		public function packMsgHeader(bytes:ByteArray) : void
		{			
			bytes.writeShort(_msgHeader.msg_id);			
			bytes.writeShort(_msgHeader.msg_type);
			bytes.writeInt(_msgHeader.msg_seq);
			bytes.writeByte(_msgHeader.src_fe);
			bytes.writeByte(_msgHeader.dest_fe);			
			bytes.writeShort(_msgHeader.src_id);			
			bytes.writeShort(_msgHeader.dest_id);
			
			bytes.writeShort(_msgHeader.param_len);
		}
		
		public function packMsgParam(bytes:ByteArray) : void
		{
			throw new AbstractFunctionError();
		}
	}
}