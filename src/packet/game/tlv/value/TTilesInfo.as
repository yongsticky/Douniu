package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;
	
	public class TTilesInfo extends TLVValue
	{
		public var tile_num:int;		// short(2)
		public var tiles:String;		// char[]
		
		public function TTilesInfo()
		{
			super();			
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeShort(tile_num);
			if (tile_num > 0)
			{
				bytes.writeUTFBytes(tiles);
			}
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			tile_num = bytes.readShort();
			if (tile_num > 0)
			{
				tiles = bytes.readUTFBytes(tile_num);
			}
			
			super.adjustPosition(bytes);
		}
	}
}