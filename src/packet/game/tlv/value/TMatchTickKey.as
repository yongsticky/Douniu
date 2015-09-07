package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	import packet.game.tlv.TLVValue;

	public class TMatchTickKey extends TLVValue
	{
		public var match_ticket_key_len:int;			// short(2)
		public var match_ticket_key:String;			// char[]
		
		public function TMatchTickKey()
		{
			super();
		}
	

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
				
			bytes.writeShort(match_ticket_key_len);
			if (match_ticket_key_len > 0)
			{
				bytes.writeUTFBytes(match_ticket_key);
			}			
				
			super.adjustPosition(bytes);
		}
			
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			match_ticket_key_len = bytes.readShort();
			if (match_ticket_key_len > 0)
			{
				match_ticket_key = bytes.readUTFBytes(match_ticket_key_len);
			}			
				
			super.adjustPosition(bytes);
		}
	}
}