package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tv.TVValue;
	
	public class NotifyFinish extends TVValue
	{
		public var finish_info_num:int;					// short(2)
		public var finish_info_vec:Vector.<FinishInfo>;	// ?
			
		public function NotifyFinish()
		{
			super();
			
			finish_info_vec = new Vector.<FinishInfo>();
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{			
			finish_info_num = bytes.readShort();
			if (finish_info_num > 0)
			{
				var _facatory:NiuObjectFactory = NiuObjectFactory.instance();
				for (var i:int = 0; i < finish_info_num; i++)
				{
					var fin:FinishInfo = _facatory.createInstance(FinishInfo);
					if (fin)
					{
						fin.unpack(bytes);
						finish_info_vec.push(fin);
					}
				}
			}
			
			super.unpack(bytes);
		}
		
		override public function dispose() : void
		{
			var _facatory:NiuObjectFactory = NiuObjectFactory.instance();
			
			for each(var item:FinishInfo in finish_info_vec)
			{
				item.dispose();
				_facatory.destroyInstance(item);
			}
		}
	}
}