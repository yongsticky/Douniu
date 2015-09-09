package packet.game.tv
{
	public class TVType
	{
		public static const SO_REQUEST_DEALER:int = 2;		// 请求抢庄
		public static const SO_REQUEST_BET:int = 4;			// 请求压注
		public static const SO_REQUEST_GIVE:int = 6;			// 请求出牌
		
		public function TVType()
		{
			throw new Error("Abstract class, you must extend it.");
		}
	}
}