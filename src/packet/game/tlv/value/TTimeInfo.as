package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;
	
	public class TTimeInfo extends TLVValue
	{
		public var type_:int;			// char(1)
		public var time_:int;			// char(1)
		
		public function TTimeInfo()
		{
			super();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(type_);
			bytes.writeByte(time_);
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			type_ = bytes.readByte();
			time_ = bytes.readByte();
			
			super.adjustPosition(bytes);
		}
	}
}