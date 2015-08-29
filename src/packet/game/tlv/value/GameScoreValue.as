package packet.game.tlv.value
{
	import packet.util.Int64;
	import flash.utils.ByteArray;

	public class GameScoreValue extends TLVValue
	{
		public static const MAX_GAME_SCORE_NUM:int = 32;
		public var game_score_vec:Vector.<Int64>;

		public function GameScoreValue()
		{
			super();

			game_score_vec = new Vector.<Int64>(MAX_GAME_SCORE_NUM);
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack();

			for (var i:int = 0; i < MAX_GAME_SCORE_NUM; i++)
			{
				game_score_vec[i].writeToBytes(bytes);
			}
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack();

			for (var i:int = 0; i < MAX_GAME_SCORE_NUM; i++)
			{
				game_score_vec[i].readFromBytes(bytes);
			}
		}
	}
}