package packet.game.tlv.value
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	
	import packet.game.tlv.TLVValue;
	import packet.game.tlv.UnionTLV;	
	import packet.game.tlv.PlayerDetailUnionTLVDecoder;
	import packet.util.Int64;

	public class PlayerDetailInfo extends TLVValue
	{
		public var player_id:int;				// int(4)
		public var player_uin:uint;				// unsigned int(4)
		public var player_status:int;			// short(2)
		public var table_id:int;				// short(2)
		public var seat_id:int;					// short(2)
		public var nick_len:int;				// short(2)
		public var nick:String;					// char[]
		public var age:int;						// char(1)
		public var gender:int;					// char(1)
		public var level:int;					// short(2)
		public var experience:int;				// unsigned int(4)
		public var money:Int64;					// int64(8)
		public var heart_count:int;				// short(2)
		public var open_id_len:int;				// short(2)
		public var open_id:String;				// char[]
		public var avatar_id:int;				// int(4)
		public var avatar_level:int;			// int(4)
		public var avatar_skill_num:int;		// int(4)
		public var avatar_skill_id:Vector.<int>;// int[]
		public var client_type:int;				// int(4)
		public var account_type:int;			// int(4)
		public var head_url_len:int;			// short(2)
		public var head_url:String;				// char[]
		public var score:Int64;					// int64(8)
		public var ident_len:int;				// short(2)
		public var ident_info:ByteArray;			// char[]
		public var using_face_item_id:int;		// int(4)
		public var player_detail_tlv:UnionTLV;	// UnionTLV
		
		public function PlayerDetailInfo()
		{
			super();
			
			money = new Int64();
			score = new Int64();
			avatar_skill_id = new Vector.<int>();
			ident_info = new ByteArray();
			
		}

		override public function pack(bytes:ByteArray):void
		{
			super.pack(bytes);

			bytes.writeInt(player_id);
			bytes.writeInt(player_uin);
			bytes.writeShort(player_status);
			bytes.writeShort(table_id);
			bytes.writeShort(seat_id);
			bytes.writeShort(nick_len);
			if (nick_len > 0)
			{
				bytes.writeUTFBytes(nick)
			}
			bytes.writeByte(age);
			bytes.writeByte(gender);			
			bytes.writeShort(level);			
			bytes.writeUnsignedInt(experience);
			money.writeToBytes(bytes);
			bytes.writeShort(heart_count);
			bytes.writeShort(open_id_len);
			if (open_id_len > 0)
			{
				bytes.writeUTFBytes(open_id);
			}
			bytes.writeInt(avatar_id);
			bytes.writeInt(avatar_level);
			bytes.writeInt(avatar_skill_num);
			for (var i:int = 0; i < avatar_skill_num; i++)
			{
				bytes.writeInt(avatar_skill_id[i]);
			}
			bytes.writeInt(client_type);
			bytes.writeInt(account_type);			
			bytes.writeShort(head_url_len);
			if (head_url_len > 0)
			{
				bytes.writeUTFBytes(head_url);
			}
			score.writeToBytes(bytes);
			bytes.writeShort(ident_len);
			if (ident_len > 0)
			{
				bytes.writeBytes(ident_info, 0, ident_len);
			}
			bytes.writeInt(using_face_item_id);
			player_detail_tlv.pack(bytes);
			
			super.adjustPosition(bytes);
		}
		
		override public function unpack(bytes:ByteArray):void
		{
			super.unpack(bytes);			
			
			player_id = bytes.readInt();
			player_uin = bytes.readUnsignedInt();
			player_status = bytes.readShort();
			table_id = bytes.readShort();
			seat_id = bytes.readShort();
			nick_len = bytes.readShort();
			if (nick_len > 0)
			{
				nick = bytes.readUTFBytes(nick_len);
			}
			age = bytes.readUnsignedByte();
			gender = bytes.readUnsignedByte();
			level = bytes.readShort();
			experience = bytes.readUnsignedInt();
			money.readFromBytes(bytes);
			heart_count = bytes.readShort();
			open_id_len = bytes.readShort();
			if (open_id_len > 0)
			{
				open_id = bytes.readUTFBytes(open_id_len);
			}
			avatar_id = bytes.readInt();
			avatar_level = bytes.readInt();
			avatar_skill_num = bytes.readInt();
			for (var i:int = 0; i < avatar_skill_num; i++)
			{
				var id:int = bytes.readInt();
				avatar_skill_id.push(id);
			}
			client_type = bytes.readInt();
			account_type = bytes.readInt();
			head_url_len = bytes.readShort();
			if (head_url_len > 0)
			{
				head_url = bytes.readUTFBytes(head_url_len);
			}
			score.readFromBytes(bytes);
			ident_len = bytes.readShort();
			if (ident_len > 0)
			{
				bytes.readBytes(ident_info, 0, ident_len);
			}
			using_face_item_id = bytes.readInt();
			player_detail_tlv = PlayerDetailUnionTLVDecoder.instance().decode(bytes);
			
			
			super.adjustPosition(bytes);
		}
		
		override public function onObjectRecycled() : void
		{
			super.onObjectRecycled();
			
			avatar_skill_id.length = 0;
			
			NiuObjectFactory.instance().destroyInstance(player_detail_tlv);			
			player_detail_tlv = null;
		}
	}
}