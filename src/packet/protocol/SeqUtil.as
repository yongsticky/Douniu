package packet.protocol
{
	public class SeqUtil
	{
		public function SeqUtil()
		{
			throw new Error("static class.");
		}
		
		private static var _curSeq:int = 100;
		
		public static function getNextSeq() : int
		{
			return _curSeq++;
		}
	}
}