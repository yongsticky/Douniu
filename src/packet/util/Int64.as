package packet.util
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import camu.errors.BufferOverflowError;
	import camu.errors.UnhandledBranchError;

	public class Int64
	{
		private var _lowPart:uint;
		private var _highPart:int;
		
		public function Int64()
		{
		}
		
		public function get lowPart() : uint
		{
			return _lowPart;
		}
		
		public function set lowPart(value:uint) : void
		{
			_lowPart = value;
		}
		
		public function get highPart() : int
		{
			return _highPart;
		}
		
		public function set highPart(value:int) : void
		{
			_highPart = value;
		}
		
		public function writeToBytes(bytes:ByteArray) : void
		{
			if (bytes.endian == Endian.BIG_ENDIAN)
			{
				bytes.writeInt(_highPart);
				bytes.writeUnsignedInt(_lowPart);
			}
			else if (bytes.endian == Endian.LITTLE_ENDIAN) 
			{
				bytes.writeUnsignedInt(_lowPart);
				bytes.writeInt(_highPart);				
			}
			else
			{
				throw new UnhandledBranchError();							
			}			
		}
		
		public function readFromBytes(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable >= 8)
			{
				if (bytes.endian == Endian.BIG_ENDIAN)
				{	
					// 先读的是低位
					_highPart = bytes.readInt();
					_lowPart = bytes.readUnsignedInt();					
				}
				else if (bytes.endian == Endian.LITTLE_ENDIAN)
				{
					_lowPart = bytes.readUnsignedInt();
					_highPart = bytes.readInt();
				}
				else
				{
					throw new UnhandledBranchError();
				}	
			}
			else
			{				
				throw new BufferOverflowError();
			}			
		}
	}
}