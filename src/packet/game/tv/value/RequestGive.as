package packet.game.tv.value
{
	import packet.game.tv.TVValue;
	
	public class RequestGive extends TVValue
	{
		public var niu_tiles_num:int;		// short(2)
		public var niu_tiles:String;		// char[]
		public var niu_x_tiles_num:int;	// short(2)
		public var niu_x_tiles:String;		// char[]
		
		public function RequestGive()
		{
			super();
		}
	}
}