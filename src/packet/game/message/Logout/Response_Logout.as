package packet.game.message.Logout
{
	import flash.utils.ByteArray;
	
	import packet.game.message.ResponseResult;
	import packet.protocol.NiuResponsePacket;
	
	public class Response_Logout extends NiuResponsePacket
	{
		public var rresult:ResponseResult;		// ?
		public var logout_reason:int;			// short(2)
		public function Response_Logout()
		{
			super();
			
			rresult = new ResponseResult();
		}
						
		override public function unpackMsgParam(bytes:ByteArray) : void
		{
			rresult.unpack(bytes);
			logout_reason = bytes.readShort();
		}
	}
}