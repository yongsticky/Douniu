package packet.game.message.Notify
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
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
		
		override public function dispose() : void
		{
			super.dispose();
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:TGameEvent in game_event_vec)
			{				
				_factory.destroyInstance(item);
			}
			
			game_event_num = 0;
			game_event_vec.length = 0;
		}
	}
}