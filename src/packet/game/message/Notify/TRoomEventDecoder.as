package packet.game.message.Notify
{
	import flash.utils.ByteArray;
	
	import camu.errors.NullObjectError;
	
	import factory.NiuObjectFactory;
	
	public class TRoomEventDecoder
	{
		public function TRoomEventDecoder(inner:PrivateInner)
		{
		}
		
		private static var _instance:TRoomEventDecoder = null;
		public static function instance() : TRoomEventDecoder
		{
			if (!_instance)
			{
				_instance = new TRoomEventDecoder(new PrivateInner());
			}
			
			return _instance;
		}

		public function decode(bytes:ByteArray) : TRoomEvent
		{
			var gameEvent:TRoomEvent = NiuObjectFactory.instance().createInstance(TRoomEvent);
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