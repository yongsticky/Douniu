package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	import packet.game.tlv.TLVValue;

	public class TPlayerCountNormalItemChangeInfo extends TLVValue
	{
		public var item_change_reason:int;			// short(2)
		public var item_id:int;						// int(4)
		public var item_change_count:int;			// int(4)
		public var item_cur_count:int;				// int(4)
		
		public function TPlayerCountNormalItemChangeInfo()
		{
			super();
		}
	

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
					
			bytes.writeShort(item_change_reason);
			bytes.writeInt(item_id);
			bytes.writeInt(item_change_count);
			bytes.writeInt(item_cur_count);
						
			super.adjustPosition(bytes);
		}
				
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
				
			item_change_reason = bytes.readShort();
			item_id = bytes.readInt();
			item_change_count = bytes.readInt();
			item_cur_count = bytes.readInt();
				
			super.adjustPosition(bytes);
		}
	}
}