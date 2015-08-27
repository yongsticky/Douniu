package packet.game.Login
{
	import flash.utils.ByteArray;	
	import packet.game.MSGID;
	
	import camu.util.ShortIntUtil;	
	import packet.protocol.NiuRequestPacket;

	public class Request_Login extends NiuRequestPacket
	{		
		public var uin:uint;					// unsigned int(4)
		public var request_src:int;			// short(2)
		public var login_life_style:int;		// unsigned int(4)
		public var room_id:int;				// unsigned int(4)
		public var tc_client_info:TClientInfo;	// struct
		public var tlv_num:int;				// short(2)
		
		public var imei_len:int;				// short(2)
		public var imei:String;				// char[]		
		
		
		public function Request_Login()
		{
			super();
			
			initCsHeader();
			initMsgHeader();
			
			_msgHeader.msg_id = MSGID.REQUEST_LOGIN;				
			tc_client_info = new TClientInfo();
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
			ShortIntUtil.writeShortInt(bytes, request_src);
			bytes.writeInt(login_life_style);
			bytes.writeInt(room_id);
			
			tc_client_info.pack(bytes);
			
			ShortIntUtil.writeShortInt(bytes, tlv_num);
			if (tlv_num > 0)
			{				
			}
			ShortIntUtil.writeShortInt(bytes, imei_len);
			if(imei_len > 0)
			{				
			}		
		}
	}
}