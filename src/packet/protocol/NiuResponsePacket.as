package packet.protocol
{
	import flash.utils.ByteArray;
	
	import camu.net.Packet;
	
	public class NiuResponsePacket extends Packet
	{		
		protected var _csHeader:CsHeader;
		protected var _msgHeader:MsgHeader;
		protected var _isInWrapperMessage:Boolean;

		protected var _isOK:Boolean;
		
		
		public function NiuResponsePacket()
		{
			super();
			
			_csHeader = new CsHeader();
			_msgHeader = new MsgHeader();
			_isInWrapperMessage = false;
			_isOK = true;
		}

		public function set isInWrapperMessage(inWrapperMessage:Boolean) : void
		{
			_isInWrapperMessage = inWrapperMessage;
		}

		public function get isInWrapperMessage() : Boolean
		{
			return _isInWrapperMessage;
		}

		public function unpack(bytes:ByteArray) : Boolean
		{			
			if (!_isInWrapperMessage)
			{
				unpackCsHeader(bytes);
			}
			
			if (_isOK)
			{
				unpackMsgHeader(bytes);
			}
			
			if (_isOK)
			{				
				if (bytes.bytesAvailable < _msgHeader.param_len - 2)
				{
					_isOK = false;
				}				
				else
				{
					unpackMsgParam(bytes);	
				}
			}
		
			return _isOK;
		}
		
		
		public function unpackCsHeader(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < CsHeader.BASE_LENGTH)
			{
				_isOK = false;
				return;
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
					_isOK = false;
					return;
				}

				bytes.readBytes(_csHeader.opt, 0, _csHeader.opt_len);
			}			
		}
		
		public function unpackMsgHeader(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < MsgHeader.BASE_LENGTH)
			{
				_isOK = false;
			}

			_msgHeader.msg_id = bytes.readShort();
			_msgHeader.msg_type = bytes.readShort();
			_msgHeader.msg_seq = bytes.readInt();
			_msgHeader.src_fe = bytes.readByte();
			_msgHeader.dest_fe = bytes.readByte();
			_msgHeader.src_id = bytes.readShort();
			_msgHeader.dest_id = bytes.readShort();
			_msgHeader.param_len = bytes.readShort();
		}
		
		public function unpackMsgParam(bytes:ByteArray) : void
		{				
			throw new Error("Abstract function!");
		}
	}
}