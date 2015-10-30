package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import douniu.NiuCard;
	
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

		override public function printValue(logger:ILogger) : void
		{		
			logger.log(this, "**************************************", LEVEL.INFO);			
			logger.log(this, "print FinishInfo value", LEVEL.INFO);
			
			logger.log(this, "seat_id:", seat_id, LEVEL.INFO);
			logger.log(this, "tiles_num:", tiles_num, LEVEL.INFO);
			
			for (var i:int = 0; i < tiles_num; ++i)
			{
				logger.log(this, "tiles[", i, "] = ", tiles[i], "[", NiuCard.getNumber(tiles[i]), "].", LEVEL.INFO);	
			}	
			
			logger.log(this, "money", money.highPart, money.lowPart, LEVEL.INFO);

			super.printValue(logger);

			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}