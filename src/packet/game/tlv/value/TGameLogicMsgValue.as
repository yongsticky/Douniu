package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;

	public class TGameLogicMsgValue extends TLVValue
	{
		public var game_buf_len:int;			// short(2)
		public var game_buf:ByteArray;			// char[]
		
		public function TGameLogicMsgValue()
		{
			super();
			
			game_buf = new ByteArray();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeShort(game_buf_len);
			if (game_buf_len > 0)
			{
				bytes.writeBytes(game_buf, 0, game_buf_len);
			}			
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			game_buf_len = bytes.readShort();
			if (game_buf_len > 0)
			{
				bytes.readBytes(game_buf, 0, game_buf_len);
			}			
			
			super.adjustPosition(bytes);
		}
		
		override public function onObjectRecycled() : void
		{
			game_buf.clear();
			game_buf_len = 0;
		}
	}
}