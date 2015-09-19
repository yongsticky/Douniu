package packet.game.message.Notify
{
	import flash.utils.ByteArray;
	
	import camu.errors.NullObjectError;
	
	import factory.NiuObjectFactory;
	
	public class TGameEventDecoder
	{
		public function TGameEventDecoder(inner:PrivateInner)
		{
		}
		
		private static var _instance:TGameEventDecoder = null;
		public static function instance() : TGameEventDecoder
		{
			if (!_instance)
			{
				_instance = new TGameEventDecoder(new PrivateInner());
			}
			
			return _instance;
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
				
				return gameEvent;
			}
			
							
			throw new NullObjectError();			
		}
	}
}

class PrivateInner
{
	
}