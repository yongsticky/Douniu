package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tlv.TLVValue;

	public class TAppointmentKey extends TLVValue
	{
		public var appointment_key_len:int;		// short(2)
		public var appointment_key:ByteArray;		// char[]
		
		public function TAppointmentKey()
		{
			super();
			
			appointment_key = new ByteArray();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);	
			
			bytes.writeShort(appointment_key_len);
			if (appointment_key_len > 0)
			{
				bytes.writeBytes(appointment_key, 0, appointment_key_len);
			}
			

		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			appointment_key_len = bytes.readShort();
			if (appointment_key_len > 0)
			{
				bytes.readBytes(appointment_key, 0, appointment_key_len);
			}
			

		}
		
		override public function onObjectRecycled() : void
		{
			appointment_key.clear();
			appointment_key_len = 0;
		}
	}
}