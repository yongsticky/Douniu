package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tv.TVValue;
	
	public class RequestGive extends TVValue
	{
		public var tiles_num:int;		// short(2)
		public var tiles:ByteArray;	// char[]		
		
		public function RequestGive()
		{
			super();
			
			tiles = new ByteArray();			
		}


		override public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(tiles_num);
			if (tiles_num > 0)
			{
				bytes.writeBytes(tiles, 0, tiles_num);
			}

			super.pack(bytes);
		}

		override public function unpack(bytes:ByteArray) : void
		{
			
		}
		
		override public function dispose() : void
		{			
			tiles.clear();
			tiles_num = 0;
			
			super.dispose();
		}
	}
}