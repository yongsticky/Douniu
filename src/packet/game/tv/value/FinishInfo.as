package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tv.TVValue;
	import packet.util.Int64;
	
	public class FinishInfo extends TVValue
	{
		public var seat_id:int;		// byte(1)		
		public var tiles_num:int;		// short(2)
		public var tiles:ByteArray;	// char[]
		public var money:Int64;		// int64(8)
		
		public function FinishInfo()
		{
			super();
			
			tiles = new ByteArray();
			money = new Int64();			
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			seat_id = bytes.readByte();
			
			tiles_num = bytes.readShort();
			if (tiles_num > 0)
			{
				bytes.readBytes(tiles, 0, tiles_num);
			}
			
			money.readFromBytes(bytes);
			
			super.unpack(bytes);
		}
		
		override public function dispose() : void
		{
			tiles.clear();
			tiles_num = 0;
			money.highPart = money.lowPart = 0;
			
			super.dispose();
		}
	}
}