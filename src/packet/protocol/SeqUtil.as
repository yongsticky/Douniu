package packet.protocol
{
	import camu.errors.AbstractClassError;

	public class SeqUtil
	{
		public function SeqUtil()
		{
			throw new AbstractClassError();
		}
		
		private static var _curSeq:int = 100;
		
		public static function getNextSeq() : int
		{
			return _curSeq++;
		}
	}
}