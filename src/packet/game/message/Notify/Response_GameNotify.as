package packet.game.message.Notify
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tlv.UnionTLV;
	import packet.protocol.NiuResponsePacket;
	
	public class Response_GameNotify extends NiuResponsePacket
	{
		public var game_event_num:int;						// short(2)
		public var game_event_vec:Vector.<TGameEvent>;		// ?
		
		public function Response_GameNotify()
		{
			super();
			
			game_event_vec = new Vector.<TGameEvent>();
		}
		
		override public function unpackMsgParam(bytes:ByteArray):void
		{
			game_event_num = bytes.readShort();
			if (game_event_num > 0)
			{
				var decoder:TGameEventDecoder = TGameEventDecoder.instance();
				for (var i:int = 0; i < game_event_num; i++)
				{
					var gameEvent:TGameEvent = decoder.decode(bytes);
					game_event_vec.push(gameEvent);
				}
			}
		}
		
		override public function onObjectRecycled() : void
		{
			super.onObjectRecycled();
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:TGameEvent in game_event_vec)
			{				
				_factory.destroyInstance(item);
			}
			
			game_event_num = 0;
			game_event_vec.length = 0;
		}
		
		override public function printResponse(logger:ILogger) : void
		{
			logger.log("***********************************************", LEVEL.INFO);
			logger.log("print Response_GameNotify.", LEVEL.INFO);
			
			logger.log("game_event_num:", game_event_num, LEVEL.INFO);
			
			for each(var ge:TGameEvent in game_event_vec)
			{
				logger.log("TGameEvent.event_id:", ge.event_id, LEVEL.INFO);
				logger.log("TGameEvent.player_id:", ge.player_id, LEVEL.INFO);
				logger.log("TGameEvent.room_id:", ge.room_id, LEVEL.INFO);
				logger.log("TGameEvent.table_id:", ge.table_id, LEVEL.INFO);
				logger.log("TGameEvent.seat_id:", ge.seat_id, LEVEL.INFO);
				logger.log("TGameEvent.other_info_num:", ge.other_info_num, LEVEL.INFO);
				for each(var tlv:UnionTLV in ge.other_info_vec)
				{
					logger.log("TGameEvent.other_info_vec.UnionTLV.valueType", tlv.valueType, LEVEL.INFO);	
				}			
			}			
			
			logger.log("***********************************************", LEVEL.INFO);
		}
	}
}