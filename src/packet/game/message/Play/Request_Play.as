package packet.game.message.Play
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.MSGID;
	import packet.game.tv.UnionTV;
	import packet.protocol.NiuRequestPacket;
	
	public class Request_Play extends NiuRequestPacket
	{
		
		public var uin:uint;				// unsigned int(4)
		public var time:int;				// int(4)
		public var data_len:int;			// short(2)
		public var tv_data:UnionTV;		// char[] ?
		
		public function Request_Play()
		{
			super();

			tv_data = NiuObjectFactory.instance().createInstance(UnionTV);
		}
		
		override protected function initData() : void
		{
			msgHeader.msg_id = MSGID.REQUEST_PLAY; 
		}
		
		override public function packMsgParam(bytes:ByteArray) : void
		{
			bytes.writeUnsignedInt(uin);
			bytes.writeInt(time);
			
			// 空1个short出来，存储长度
			bytes.position += 2;
			
			// 编码data
			var posBeg:int = bytes.position; 
			tv_data.pack(bytes);
			var posEnd:int = bytes.position;
			
			// 将长度写回
			bytes.position = posBeg - 2;
			bytes.writeShort(posEnd - posBeg);
			
			// 将bytes的position恢复
			bytes.position = posEnd;
		}
		
		public function dispose() : void
		{
			if (tv_data)
			{
				tv_data.dispose();
				NiuObjectFactory.instance().destroyInstance(tv_data);
				
				tv_data = null;			
			}
			
			data_len = 0;
		}		
	}
}