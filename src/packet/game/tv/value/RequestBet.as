package packet.game.tv.value
{
	import packet.game.tv.TVValue;
	
	public class RequestBet extends TVValue
	{
		public var times:int;			// Byte(1) 
		
		public function RequestBet()
		{
			super();
		}
	}
}