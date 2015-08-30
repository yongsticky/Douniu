package packet.game.message
{
	import flash.utils.ByteArray;
	
	public class ResponseResult
	{
		public var result_id:int;		// unsigned int(4)
		public var result_str_len:int;	// short(2)
		public var result_str:String;	// char[]


		public function ResponseResult()
		{
		}

		public function unpack(bytes:ByteArray) : void
		{
			result_id = bytes.readUnsignedInt();
			result_str_len = bytes.readShort();
			if (result_str_len > 0)
			{
				result_str = bytes.readUTFBytes(result_str_len);
			}
		}
	}
}