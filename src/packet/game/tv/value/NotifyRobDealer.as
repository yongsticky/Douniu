package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tv.TVValue;
	
	public class NotifyRobDealer extends TVValue
	{
		public var multiple_num:int;			// short(2)
		public var multiple:ByteArray;			// char[]
			
		
		public function NotifyRobDealer()
		{
			super();
			
			multiple = new ByteArray();			
		}
		
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			multiple_num = bytes.readShort();						
			bytes.readBytes(multiple, 0, multiple_num);
			
			super.unpack(bytes);
		}
		
		override public function dispose() : void
		{
			multiple.clear();
			multiple_num = 0;
			
			super.dispose();			
		}
	}
}