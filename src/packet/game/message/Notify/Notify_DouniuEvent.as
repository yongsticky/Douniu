package packet.game.message.Notify
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tv.UnionTV;
	import packet.game.tv.UnionTVDecoder;
	import packet.protocol.NiuResponsePacket;	
	
	public class Notify_DouniuEvent extends NiuResponsePacket
	{
		public var data_len:int;		// short(2)
		public var flag:int;			// unsigned int(4)
		public var tv_data:UnionTV;	// ?
		
		
		public function Notify_DouniuEvent()
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
			logger.log(this, "***********************************************", LEVEL.INFO);
			logger.log(this, "print Notify_DouniuEvent.", LEVEL.INFO);
			
			logger.log(this, "data_len:", data_len, LEVEL.INFO);
			logger.log(this, "flag:", flag, LEVEL.INFO);
			logger.log(this, "tv_data.type:", tv_data.valueType, LEVEL.INFO);
			logger.log(this, "tv_data.errno:", tv_data.errorNo, LEVEL.INFO);
			logger.log(this, "tv_data.value.tlv_num:", tv_data.value.tlv_num, LEVEL.INFO);			
			tv_data.value.printValue(logger);				
			
			logger.log(this, "***********************************************", LEVEL.INFO);
		}
	}
}