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


		override public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(niu_tiles_num);
			if (niu_tiles_num > 0)
			{
				bytes.writeUTFBytes(niu_tiles);
			}

			bytes.writeShort(niu_x_tiles_num);
			if (niu_x_tiles_num > 0)
			{
				bytes.writeUTFBytes(niu_x_tiles);
			}

			super.pack(bytes);
		}

		override public function unpack(bytes:ByteArray) : void
		{
			
		}
	}
}