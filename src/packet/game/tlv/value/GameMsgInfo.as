package packet.game.tlv.value
{
	import flash.utils.ByteArray;
		
	import packet.game.tlv.TLVValue;

	public class GameMsgInfo extends TLVValue
	{
		public var game_msg_info_len:int;
		public var game_msg_info:String;

		public function GameMsgInfo()
		{
			super();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);

			bytes.writeShort(game_msg_info_len);
			if (game_msg_info_len > 0)
			{
				bytes.writeUTFBytes(game_msg_info);
			}
			

		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);

			game_msg_info_len = bytes.readShort();
			if (game_msg_info_len > 0)
			{
				bytes.readUTFBytes(game_msg_info_len);
			}
			

		}
	}
}