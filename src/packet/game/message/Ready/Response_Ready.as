package packet.game.message.Ready
{
	import flash.utils.ByteArray;
		
	import packet.protocol.NiuResponsePacket;
	import packet.game.tlv.UnionTLV;	
	import packet.game.tlv.UnionTLVDecoder;
	import packet.game.message.ResponseResult;
	
	public class Response_Ready extends NiuResponsePacket
	{
		public var rresult:ResponseResult;		// ?
		public var tlv_num:int;					// short(2)
		public var tlv_vec:Vector.<UnionTLV>;	// ?

		public function Response_Ready()
		{
			super();
			
			rresult = new ResponseResult();
			tlv_vec = new Vector.<UnionTLV>();
		}


		override public function unpackMsgParam(bytes:ByteArray) : void
		{			
			rresult.unpack(bytes);
			tlv_num = bytes.readShort();
			if (tlv_num > 0)
			{
				var _uTLVDecoder:UnionTLVDecoder = UnionTLVDecoder.instance();
				for (var i:int = 0; i < tlv_num; i++)
				{
					var utlv:UnionTLV = _uTLVDecoder.decode(bytes);
					tlv_vec.push(utlv);						
				}
			}
		}

	}
}