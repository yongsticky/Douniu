package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tlv.TLVValue;
	
	public class TTimerInfo extends TLVValue
	{
		public var type_:int;			// char(1)
		public var time_:int;			// char(1)
		
		public function TTimerInfo()
		{
			super();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(type_);
			bytes.writeByte(time_);
			

		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			type_ = bytes.readByte();
			time_ = bytes.readByte();
			

		}

		override public function printValue(logger:ILogger) : void
		{
			logger.log(this, "**************************************", LEVEL.INFO);
			logger.log(this, "print TTimerInfo value", LEVEL.INFO);
			logger.log(this, "type:", type_, LEVEL.INFO);
			logger.log(this, "time:", time_, LEVEL.INFO);
			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}