package packet.game.tlv.value
{
	import flash.utils.ByteArray;
		
	import packet.game.tlv.TLVValue;

	public class TAppointmentKey extends TLVValue
	{
		public var appointment_key_len:int;		// short(2)
		public var appointment_key:String;			// char[]
		
		public function TAppointmentKey()
		{
			super();
		}
		
		/*
		override public function getValueType() : int
		{
			return TLVType.UP_TLV_APPOINTMENT_KEY;
		}
		*/
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);	
			
			bytes.writeShort(appointment_key_len);
			if (appointment_key_len > 0)
			{
				bytes.writeUTFBytes(appointment_key);
			}
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			appointment_key_len = bytes.readShort();
			if (appointment_key_len > 0)
			{
				appointment_key = bytes.readUTFBytes(appointment_key_len);
			}
			
			super.adjustPosition(bytes);
		}
	}
}