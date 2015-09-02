package packet.game.tlv.value
{
	import flash.utils.ByteArray;

	public class TPlayerAvatarChangeInfo extends TLVValue
	{
		public var change_type:int;			// short(2)
		public var avatar_id:int;				// int(4)
		public var seq:int;					// int(4)
		public var buy_time:int;				// int(4)
		public var valid_time:int;				// int(4)
		public var expr:int;					// int(4)
		public var level:int;					// int(4)
		public var skill:int;					// int(4)
		
		
		public function TPlayerAvatarChangeInfo()
		{
			super();
		}

		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
				
			bytes.writeShort(change_type);
			bytes.writeInt(avatar_id);
			bytes.writeInt(seq);
			bytes.writeInt(buy_time);
			bytes.writeInt(valid_time);
			bytes.writeInt(expr);
			bytes.writeInt(level);
			bytes.writeInt(skill);
						
			super.adjustPosition(bytes);
		}
			
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			change_type = bytes.readShort();
			avatar_id = bytes.readInt();
			seq = bytes.readInt();
			buy_time = bytes.readInt();
			valid_time = bytes.readInt();
			expr = bytes.readInt();
			level = bytes.readInt();
			skill = bytes.readInt();		
				
			super.adjustPosition(bytes);
		}
	}
}