package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class TGameLogicMsgValue extends TLVValue
	{
		public var game_buf_len:int;			// short(2)
		public var game_buf:String;			// char[]
		
		public function TGameLogicMsgValue()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeShort(game_buf_len);
			if (game_buf_len > 0)
			{
				bytes.writeUTFBytes(game_buf);
			}			
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			game_buf_len = bytes.readShort();
			if (game_buf_len > 0)
			{
				game_buf = bytes.readUTFBytes(game_buf_len);
			}			
			
			super.adjustPosition(bytes);
		}
	}
}