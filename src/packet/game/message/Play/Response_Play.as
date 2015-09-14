package packet.game.message.Play
{
	import flash.utils.ByteArray;
	
	import packet.game.message.ResponseResult;
	import packet.protocol.NiuResponsePacket;
	
	public class Response_Play extends NiuResponsePacket
	{
		public var rr:ResponseResult;
		public function Response_Play()
		{
			super();
			
			rr = new ResponseResult();
		}
		
		override public function unpackMsgParam(bytes:ByteArray) : void
		{
			rr.unpack(bytes);
		}
	}
}