package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tlv.TLVValue;
	
	public class TDNPlayInfo extends TLVValue
	{
		public var vip_level:int;		// Byte(1)

		public function TDNPlayInfo()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(vip_level);
			

		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			vip_level = bytes.readByte();
			

		}

		override public function printValue(logger:ILogger) : void
		{
			logger.log(this, "**************************************", LEVEL.INFO);
			logger.log(this, "print TDNPlayInfo value", LEVEL.INFO);
			logger.log(this, "vip_level:", vip_level, LEVEL.INFO);			
			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}