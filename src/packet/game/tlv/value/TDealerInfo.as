package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	
	import packet.game.tlv.TLVValue;	
	
	public class TDealerInfo extends TLVValue
	{
		public var dealer:int;			// char(1)
		
		public function TDealerInfo()
		{
			super();
		}		
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(dealer);
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
						
			dealer = bytes.readByte();
			
			super.adjustPosition(bytes);
		}

		override public function printValue(logger:ILogger) : void
		{
			logger.log(this, "**************************************", LEVEL.INFO);
			logger.log(this, "print TDealerInfo value", LEVEL.INFO);
			logger.log(this, "dealer:", dealer, LEVEL.INFO);			
			logger.log(this, "**************************************", LEVEL.INFO);
		}
	}
}