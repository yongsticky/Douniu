package packet.protocol
{
	import flash.utils.ByteArray;
	
	public class NiuResponsePacket extends NiuPacket
	{	
		protected var _isWrapperedMessage:Boolean;		
		
		public function NiuResponsePacket()
		{
			super();			
			
			_isWrapperedMessage = false;		
		}
		
		override public function onObjectRecycled() : void
		{			
			super.onObjectRecycled();
						
			_isWrapperedMessage = false;
			
			
		}		
		
		public function set isWrapperedMessage(wrappered:Boolean) : void
		{
			_isWrapperedMessage = wrappered;
		}
				
		public function unpack(bytes:ByteArray) : void
		{
			if (!_isWrapperedMessage)
			{
				unpackCsHeader(bytes);
			}
			
			unpackMsgHeader(bytes);			
			unpackMsgParam(bytes);		
		}		
		
		public function unpackCsHeader(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < CsHeader.BASE_LENGTH)
			{
				throw new Error("ByteArray Length Error(BASE_LENGTH).");				
			}

			_csHeader.total_len = bytes.readShort();
			_csHeader.ver = bytes.readShort();
			_csHeader.dialog_id = bytes.readShort();
			_csHeader.seq = bytes.readInt();
			_csHeader.uin = bytes.readUnsignedInt();
			_csHeader.body_flag = bytes.readByte();
			_csHeader.opt_len = bytes.readByte();
			if (_csHeader.opt_len > 0)
			{
				if (bytes.bytesAvailable < _csHeader.opt_len)
				{
					throw new Error("ByteArray Length Error(opt_len).");					
				}

				bytes.readBytes(_csHeader.opt, 0, _csHeader.opt_len);
			}			
		}
		
		public function unpackMsgHeader(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < MsgHeader.BASE_LENGTH)
			{
				throw new Error("ByteArray Length Error(BASE_LENGTH).");
			}

			_msgHeader.msg_id = bytes.readShort();
			_msgHeader.msg_type = bytes.readShort();
			_msgHeader.msg_seq = bytes.readInt();
			_msgHeader.src_fe = bytes.readByte();
			_msgHeader.dest_fe = bytes.readByte();
			_msgHeader.src_id = bytes.readShort();
			_msgHeader.dest_id = bytes.readShort();
			
			_msgHeader.param_len = bytes.readShort();
			
			if (bytes.bytesAvailable < _msgHeader.param_len - 2)
			{
				throw new Error("ByteArray Length Error(param_len).");
			}
			
		}
		
		public function unpackMsgParam(bytes:ByteArray) : void
		{				
			throw new Error("Abstract function, you must override it.");
		}
		
		
	}
}