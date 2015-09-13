package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tv.TVValue;
	
	public class NotifyDealerDetail extends TVValue
	{
		public var seat_id:int;			// byte(1)
		public var multiple:int;			// byte(1)
				
		public function NotifyDealerDetail()
		{
			super();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			seat_id = bytes.readByte();
			multiple = bytes.readByte();
			
			super.unpack(bytes);
		}		
	}
}