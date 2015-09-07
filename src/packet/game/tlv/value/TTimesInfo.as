package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;
	
	public class TTimesInfo extends TLVValue
	{
		public var type_:int;				// char(1)
		public var times_num:int;			// short(2)
		public var times:String;			// char[]
		
		
		public function TTimesInfo()
		{
			super();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(type_);
			bytes.writeShort(times_num);
			if (times_num > 0)
			{
				bytes.writeUTFBytes(times);
			}
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			type_ = bytes.readByte();
			times_num = bytes.readShort();
			if (times_num > 0)
			{
				times = bytes.readUTFBytes(times_num);
			}			
			
			super.adjustPosition(bytes);
		}
	}
}