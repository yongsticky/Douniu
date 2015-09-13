package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tv.TVValue;
	
	public class RequestGive extends TVValue
	{
		public var niu_tiles_num:int;		// short(2)
		public var niu_tiles:ByteArray;	// char[]
		public var niu_x_tiles_num:int;	// short(2)
		public var niu_x_tiles:ByteArray;	// char[]
		
		public function RequestGive()
		{
			super();
			
			niu_tiles = new ByteArray();
			niu_x_tiles = new ByteArray();
		}


		override public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(niu_tiles_num);
			if (niu_tiles_num > 0)
			{
				bytes.readBytes(niu_tiles, 0, niu_tiles_num);
			}

			bytes.writeShort(niu_x_tiles_num);
			if (niu_x_tiles_num > 0)
			{
				bytes.readBytes(niu_x_tiles, 0, niu_x_tiles_num);
			}

			super.pack(bytes);
		}

		override public function unpack(bytes:ByteArray) : void
		{
			
		}
		
		override public function dispose() : void
		{
			niu_tiles.clear();
			niu_tiles_num = 0;
			
			niu_x_tiles.clear();
			niu_x_tiles_num = 0;
			
			super.dispose();
		}
	}
}