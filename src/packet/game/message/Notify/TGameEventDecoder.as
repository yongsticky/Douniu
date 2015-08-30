package packet.game.message.Notify
{
	import flash.utils.ByteArray;
	
	import camu.design_pattern.Singleton;
	
	import factory.NiuObjectFactory;

	public class TGameEventDecoder
	{
		public function TGameEventDecoder()
		{
		}
		
		public static function instance() : TGameEventDecoder
		{
			return Singleton.instanceOf(TGameEventDecoder);
		}
		
		public function decode(bytes:ByteArray) : TGameEvent
		{
			var gameEvent:TGameEvent = NiuObjectFactory.instance().createInstance(TGameEvent);
			if (gameEvent)
			{
				if (!gameEvent.unpack(bytes))
				{
					NiuObjectFactory.instance().destroyInstance(gameEvent);
					gameEvent = null;
				}
			}
			else
			{
				throw new Error("Not TGameEvent Class.");
			}
			
			return gameEvent;
		}
	}
}