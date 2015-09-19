package packet.game.tlv
{	
	import flash.utils.ByteArray;
	
	import camu.errors.UnexpectedLengthError;
	import camu.object.interfaces.IObjectRecycled;
	
	import factory.NiuObjectFactory;
	

	public class UnionTLV implements IObjectRecycled
	{
		protected var value_type:int;				// short(2)
		protected var tlv_value:TLVValue;				// TLVValue		
		
		public function UnionTLV(value:TLVValue = null)
		{
			value_type = 0;
			tlv_value = value;
		}
		
		public function get valueType() : int
		{
			return value_type;
		}
		
		public function set valueType(type_:int) : void
		{
			value_type = type_;
		}
		
		public function get value() : TLVValue
		{
			return tlv_value;
		}
		
		public function set value(v:TLVValue) : void
		{
			tlv_value = v;
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			if (bytes.bytesAvailable < 2)
			{
				throw new UnexpectedLengthError();
			}
			
			value_type = bytes.readShort();		
			
			tlv_value.unpack(bytes);			
		}

		public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(value_type);		
			value.pack(bytes);
		}
		
		public function onObjectRecycled() : void
		{			
			NiuObjectFactory.instance().destroyInstance(tlv_value);
			
			tlv_value = null;
		}		
	}
}