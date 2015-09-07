package packet.game.tlv.value
{
	import flash.utils.ByteArray;
		
	import packet.game.tlv.TLVValue;

	public class T3DMJPlayInfo extends TLVValue
	{
		public var gender:int;				// char(1)
		public var avatar_num:int;			// short(2)
		public var avata_vec:Vector.<int>;	// int[]


		public function T3DMJPlayInfo()
		{
			super();

			avata_vec = new Vector.<int>();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			super.pack(bytes);
			
			bytes.writeByte(gender);
			bytes.writeShort(avatar_num);
			for (var i:int = 0; i < avatar_num; i++)
			{
				bytes.writeInt(avata_vec[i]);
			}
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			super.unpack(bytes);
			
			gender = bytes.readByte();
			avatar_num = bytes.readShort();
			if (avatar_num > 0)
			{
				for (var i:int = 0; i < avatar_num; i++)
				{
					var value:int = bytes.readInt();
					avata_vec.push(value);
				}
			}	
			
			adjustPosition(bytes);
		}
		
		override public function dispose() : void
		{
			super.dispose();
			
			avatar_num = 0;
			avata_vec.length = 0;
		}
	}
}