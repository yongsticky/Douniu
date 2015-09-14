package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tlv.TLVValue;
	
	public class TTilesInfo extends TLVValue
	{
		public var tiles_num:int;		// short(2)
		public var tiles:ByteArray;	// char[]
		
		public function TTilesInfo()
		{
			super();	
			
			tiles = new ByteArray();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeShort(tiles_num);
			if (tiles_num > 0)
			{
				bytes.writeBytes(tiles, 0, tiles_num);
			}
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			tiles_num = bytes.readShort();
			if (tiles_num > 0)
			{
				bytes.readBytes(tiles, 0, tiles_num);
			}
			
			super.adjustPosition(bytes);
		}

		override public function printValue(logger:ILogger) : void
		{
			logger.log(this, "**************************************", LEVEL.INFO);
			logger.log(this, "print TTilesInfo value", LEVEL.INFO);
			logger.log(this, "tiles_num:", tiles_num, LEVEL.INFO);
			for (var i:int = 0; i < tiles_num; ++i)
			{
				logger.log(this, "tiles[", i, "] = ", tiles[i], LEVEL.INFO);	
			}	
			
			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}