package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;
	
	public class TMultipleInfo extends TLVValue
	{
		public var type_:int;					// char(1)
		public var multiple_num:int;			// short(2)
		public var multiple:ByteArray;			// char[]
		
		
		public function TMultipleInfo()
		{
			super();
			
			multiple = new ByteArray();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(type_);
			bytes.writeShort(multiple_num);
			if (multiple_num > 0)
			{
				bytes.writeBytes(multiple, 0, multiple_num);
			}
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			type_ = bytes.readByte();
			multiple_num = bytes.readShort();
			if (multiple_num > 0)
			{
				bytes.readBytes(multiple, 0, multiple_num);
			}			
			
			super.adjustPosition(bytes);
		}
	}
}