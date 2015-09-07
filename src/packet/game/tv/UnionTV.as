package packet.game.tv
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;

	public class UnionTV
	{
		public var value_type:int;				// int(4)
		public var error_no:int;				// int(4)
		public var tv_value:TVValue;			// ?:
		
		public function UnionTV(value:TVValue = null)
		{
			value_type = 0;
			error_no = 0;
			tv_value = value; 
		}
		
		
		public function get valueType() : int
		{
			return value_type;
		}
		
		public function set valueType(valueType:int) : void
		{
			value_type = valueType;
		}
		
		public function get errorNo() : int
		{
			return error_no;
		}
		
		public function set errorNo(errorNo:int) : void
		{
			error_no = errorNo;
		}
		
		public function get value() : TVValue
		{
			return tv_value;
		}
		
		public function set value(value:TVValue) : void
		{
			tv_value = value;
		}
		
		public function pack(bytes:ByteArray) : void
		{
			
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			
		}
		
		public function reset() : void
		{
			tv_value.reset();
			NiuObjectFactory.instance().destroyInstance(tv_value);
			tv_value = null;
			
			value_type = 0;
			error_no = 0;
		}
	}
}