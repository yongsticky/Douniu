package packet.game.tlv
{
	import flash.utils.ByteArray;

	public class TLVValue
	{		
		public function TLVValue()
		{			
		}	
		
		public function pack(bytes:ByteArray) : void
		{
			throw new Error("Abstract function");	
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			throw new Error("Abstract function");
		}
		 
	}
}