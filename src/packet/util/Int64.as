package packet.util
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class Int64
	{
		private var _lowPart:int;
		private var _highPart:int;
		
		public function Int64()
		{
		}
		
		public function get lowPart() : int
		{
			return _lowPart;
		}
		
		public function set lowPart(value:int) : void
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
				bytes.writeUnsignedInt(_highPart);
				bytes.writeUnsignedInt(_lowPart);
			}
			else if (bytes.endian == Endian.LITTLE_ENDIAN) 
			{
				bytes.writeUnsignedInt(_lowPart);
				bytes.writeUnsignedInt(_highPart);				
			}
			else
			{
				throw new Error("Wrong Endian.");				
			}			
		}
		
		public function readFromBytes(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable >= 8)
			{
				var low:int = bytes.readInt();
				var high:int = bytes.readInt();
				
				if (bytes.endian == Endian.BIG_ENDIAN)
				{	
					// 先读的是低位
					_highPart = bytes.readUnsignedInt();
					_lowPart = bytes.readUnsignedInt();					
				}
				else if (bytes.endian == Endian.LITTLE_ENDIAN)
				{
					_lowPart = bytes.readUnsignedInt();
					_highPart = bytes.readUnsignedInt();
				}
				else
				{
					throw new Error("Wrong Endian.");
				}	
			}
			else
			{
				throw new Error("bytesAvailable not enough.");
			}			
		}
	}
}