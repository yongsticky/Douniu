package packet.game.message.Play
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tv.UnionTV;
	import packet.game.tv.UnionTVDecoder;
	import packet.protocol.NiuResponsePacket;
	
	public class Response_Play extends NiuResponsePacket
	{
		private var data_len:int;		// short(2)
		private var flag:int;			// unsigned int(4)
		private var tv_data:UnionTV;	// ?
		
		
		public function Response_Play()
		{
			super();
		}
		
		override public function unpackMsgParam(bytes:ByteArray) : void
		{
			data_len = bytes.readShort();
			flag = bytes.readUnsignedInt();
			
			tv_data = UnionTVDecoder.instance().decode(bytes);
		}
		
		
		override public function onObjectRecycled() : void
		{
			super.onObjectRecycled();
			
			NiuObjectFactory.instance().destroyInstance(tv_data);
			
			tv_data = null;
			data_len = 0;
			flag = 0;
		}
	}
}