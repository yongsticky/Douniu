package packet.game.tv
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.UnionTLV;

	public class TVValue
	{
		public var tlv_num:int;				// short(2)		
		public var tlv:Vector.<UnionTLV>;		// ?
		
		public function TVValue()
		{
			tlv = new Vector.<UnionTLV>();
		}
		
		public function pack(bytes:ByteArray) : void
		{
			
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			
		}
		
		public function reset() : void
		{
			
		}
		
		
	}	
	
}