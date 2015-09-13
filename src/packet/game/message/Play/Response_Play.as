package packet.game.message.Play
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tv.UnionTV;
	import packet.game.tv.UnionTVDecoder;
	import packet.protocol.NiuResponsePacket;
	import packet.game.tlv.UnionTLV;
	
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
		
		override public function printResponse(logger:ILogger) : void
		{
			logger.log("***********************************************", LEVEL.INFO);
			logger.log("print Response_Play.", LEVEL.INFO);
			
			logger.log("data_len:", data_len, LEVEL.INFO);
			logger.log("flag:", flag, LEVEL.INFO);
			logger.log("tv_data.type:", tv_data.valueType, LEVEL.INFO);
			logger.log("tv_data.errno:", tv_data.errorNo, LEVEL.INFO);
			logger.log("tv_data.value.tlv_num:", tv_data.value.tlv_num, LEVEL.INFO);
			for each(var tlv:UnionTLV in tv_data.value.tlv_vec)
			{
				logger.log("tlv.type", tlv.valueType, LEVEL.INFO);
				logger.log(">>>>>", LEVEL.INFO)
			}
						
			
			logger.log("***********************************************", LEVEL.INFO);
		}
	}
}