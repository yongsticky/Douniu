package packet.game.message.Login
{
	import flash.utils.ByteArray;
	
	import packet.game.message.MSGID;
	import packet.game.tlv.TClientInfo;
	import packet.game.tlv.TLVValue;
	import packet.protocol.NiuRequestPacket;

	public class Request_Login extends NiuRequestPacket
	{		
		public var uin:uint;					// unsigned int(4)
		public var request_src:int;			// short(2)
		public var login_life_style:int;		// unsigned int(4)
		public var room_id:int;				// unsigned int(4)
		public var tc_client_info:TClientInfo;	// struct
		public var tlv_num:int;				// short(2)
		public var tlv_vec:Vector.<TLVValue>;
		public var imei_len:int;				// short(2)
		public var imei:String;				// char[]		
		
		
		public function Request_Login()
		{
			super();
			
			initCsHeader();
			initMsgHeader();
			
			_msgHeader.msg_id = MSGID.REQUEST_LOGIN;				
			
			tc_client_info = new TClientInfo();
			tlv_vec = new Vector.<TLVValue>();
			
			_csHeader.uin = uin = 700033;
			request_src = 0;
			login_life_style = 0;
			room_id = 82;
			tlv_num = 0;
			imei_len = 0;
		}
		
		
		override public function packMsgParam(bytes:ByteArray):void
		{			
			bytes.writeUnsignedInt(uin);			
			bytes.writeShort(request_src);
			bytes.writeInt(login_life_style);
			bytes.writeInt(room_id);			
			tc_client_info.pack(bytes);			
			bytes.writeShort(tlv_num);
			if (tlv_num > 0)
			{
				for (var i:int = 0; i < tlv_num; i++)
				{
					tlv_vec[i].pack(bytes);
				}
			}			
			bytes.writeShort(imei_len);
			if(imei_len > 0)
			{
				bytes.writeUTFBytes(imei);
			}		
		}
	}
}