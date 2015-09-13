package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tv.TVValue;	
	
	public class NotifyGive extends TVValue
	{	
		public function NotifyGive()
		{
			super();				
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
		}
		
		override public function dispose() : void
		{
			super.dispose();
		}
	}
}