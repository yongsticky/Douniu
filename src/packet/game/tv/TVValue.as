package packet.game.tv
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tlv.UnionTLV;

	public class TVValue
	{
		public var tlv_num:int;					// short(2)		
		public var tlv_vec:Vector.<UnionTLV>;		// ?
		
		public function TVValue()
		{
			tlv_vec = new Vector.<UnionTLV>();
		}
		
		public function pack(bytes:ByteArray) : void
		{
			
		}
		
		public function unpack(bytes:ByteArray) : void
		{
			
		}
		
		public function dispose() : void
		{
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:UnionTV in tlv_vec)
			{
				item.dispose();
				_factory.destroyInstance(item);
			}
			
			tlv_vec.length = 0;
		}
		
		
	}	
	
}