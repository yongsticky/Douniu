package packet.game.tlv
{
	import flash.utils.ByteArray;
	
	import camu.logger.Logger;
	import camu.object.interfaces.IObjectRecycled;
	import camu.logger.ILogger;


	public class TLVValue implements IObjectRecycled
	{
		public var value_len:int;		
		
		public function TLVValue()
		{			
		}		
		
		public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(value_len);
			if (bytes.bytesAvailable < value_len-2)
			{
				throw new Error("TLVValue Length Error.");
			}
			
			//end_pos = bytes.position + value_len;
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < 2)			
			{
				throw new Error("TLVValue Length Error.");
			}
			
			value_len = bytes.readShort();			
			if (bytes.bytesAvailable < value_len)
			{
				throw new Error("TLVValue Length Error.");
			}			
		}
		
		protected function adjustPosition(bytes:ByteArray) : void
		{
			/*
			if (bytes.position <= end_pos)
			{
				bytes.position = end_pos;	
			}
			else
			{
				throw new Error("ByteArray position Overflow.");
			}
			*/
		}
		
		public function onObjectRecycled() : void
		{
			
		}

		public function printValue(logger:ILogger) : void
		{

		}
		 
	}
}