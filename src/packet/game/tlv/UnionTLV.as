package packet.game.tlv
{	
	import flash.utils.ByteArray;
	
	import avmplus.getQualifiedClassName;
	
	import camu.object.BaseObjectFactory;
	import camu.object.IObjectInit;
	import camu.object.IObjectWithQualifiedSubclassNameMethod;
	
	import packet.game.tlv.value.TLVValue;

	public class UnionTLV implements IObjectWithQualifiedSubclassNameMethod, IObjectInit
	{
		protected var value_type:int;				// short(2)
		protected var tlv_value:TLVValue;				// TLVValue
		
		private var _packetFactory:BaseObjectFactory;
		
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
			valueType = type_;
		}
		
		public function get value() : TLVValue
		{
			return tlv_value;
		}
		
		public function set value(v:TLVValue) : void
		{
			tlv_value = v;
		}
		
		public function unpack(bytes:ByteArray) : Boolean
		{
			value_type = bytes.readShort();
			value.unpack(bytes);
			
			return value.isOK;
		}

		public function pack(bytes:ByteArray) : void
		{
			bytes.writeShort(value_type);
			value.pack(bytes);

		}
		
		public function onObjectCreated(factory:BaseObjectFactory) : void
		{
			_packetFactory = factory;
		}
		
		public function onObjectDestroy() : void
		{
			if (value)
			{
				_packetFactory.destroyInstance(value);
				value = null;
			}
			
			value_type = 0;
		}
		
		public function getQualifiedSubclassName() : String
		{
			var clsName:String = getQualifiedClassName(UnionTLV);
			clsName += ".";
			clsName + getQualifiedClassName(tlv_value);
			
			return clsName;
		}
	}
}