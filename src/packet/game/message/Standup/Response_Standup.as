package packet.game.message.Standup
{
	import flash.utils.ByteArray;
	
	import packet.protocol.NiuResponsePacket;
	import packet.game.message.ResponseResult;	
	
	public class Response_Standup extends NiuResponsePacket
	{
		public var rresult:ResponseResult;		// ?
		public var standup_reason:int;			// short(2)


		public function Response_Standup()
		{
			super();
			
			rresult = new ResponseResult();
		}

		override public function unpackMsgParam(bytes:ByteArray) : void
		{			
			rresult.unpack(bytes);
			standup_reason = bytes.readShort();
		}
	}
}