package packet.game
{
	import packet.protocol.NiuPacket;
	import packet.protocol.SeqUtil;

	public class Request_Login extends NiuPacket
	{
		public static const REQ_LOGIN:int = 15801;
		
		public function Request_Login()
		{
			super();
			
			_csHeader.ver = 0;
			_csHeader.dialog_id = -1;
			_csHeader.opt_len = 0;
			_csHeader.body_flag = 0;
			_csHeader.uin = 700033;
			_csHeader.seq = SeqUtil.getNextSeq();
			
			
			_msgHeader.msg_id = REQ_LOGIN;
			_msgHeader.msg_type = 0;
			_msgHeader.msg_seq = SeqUtil.getNextSeq();
			_msgHeader.src_fe = 1;
			_msgHeader.dest_fe = 158;	
			_msgHeader.src_id = 0;
			_msgHeader.dest_id = 0;
			
			_msgParam.param_len = 0;
		}
	}
}