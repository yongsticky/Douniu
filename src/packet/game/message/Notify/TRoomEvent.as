package packet.game.message.Notify
{
	import flash.utils.ByteArray;
	
	import camu.object.interfaces.IObjectRecycled;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVDecoder;
	import packet.game.tlv.value.PlayerDetailInfo;

	public class TRoomEvent implements IObjectRecycled
	{	
		public var event_id:int;						// int(4)
		public var player_id:int;						// int(4)
		public var room_id:int;						// short(2)
		public var table_id:int;						// short(2)
		public var seat_id:int;						// short(2)
		public var other_info_num:int;					// short(2)
		public var other_info_vec:Vector.<UnionTLV>;	// ?
		
		public function TRoomEvent()
		{
			other_info_vec = new Vector.<UnionTLV>();
		}
		
		public function getTLVValue(tlvType:int) : *
		{
			for each(var tlv:UnionTLV in other_info_vec)
			{
				if (tlv.valueType == tlvType)
				{
					return tlv;					
				}
			}
			
			return null;
		}
		
		public function unpack(bytes:ByteArray) : Boolean
		{
			event_id = bytes.readInt();
			player_id = bytes.readInt();
			room_id = bytes.readShort();
			table_id = bytes.readShort();
			seat_id = bytes.readShort();
			other_info_num = bytes.readShort();
			if (other_info_num > 0)
			{
				var decoder:UnionTLVDecoder = UnionTLVDecoder.instance();
				for (var i:int = 0; i < other_info_num; i++)
				{
					 var uTLV:UnionTLV = decoder.decode(bytes);
					 other_info_vec.push(uTLV);
				}
			}
			
			return true;
		}
		
		public function onObjectRecycled() : void
		{
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:UnionTLV in other_info_vec)
			{				
				_factory.destroyInstance(item);
			}
			
			other_info_num = 0;
			other_info_vec.length = 0;
		}		  
	}
}