package packet.game.tlv
{
	import flash.utils.ByteArray;
	
	import camu.errors.UnexpectedLengthError;
	import camu.logger.ILogger;
	import camu.object.interfaces.IObjectRecycled;


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
				throw new UnexpectedLengthError();
			}
			
			//end_pos = bytes.position + value_len;
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < 2)			
			{
				throw new UnexpectedLengthError();
			}
			
			value_len = bytes.readShort();			
			if (bytes.bytesAvailable < value_len)
			{
				throw new UnexpectedLengthError();
			}			
		}		
		
		public function onObjectRecycled() : void
		{
			
		}

		public function printValue(logger:ILogger) : void
		{

		}
		 
	}
}