package packet.game.tv.value
{
	import flash.utils.ByteArray;
	
	import packet.game.tv.TVValue;	
	
	public class NotifyGive extends TVValue
	{	
		/*
		public var finish_info_num:int;					// short(2)
		public var finish_info_vec:Vector.<FinishInfo>;		// ?
		public var money:Int64;
		*/
		public function NotifyGive()
		{
			super();
			
			/*
			finish_info_vec = new Vector.<FinishInfo>();
			money = new Int64();
			*/
		}
		
		override public function pack(bytes:ByteArray) : void
		{
			
		}
		
		override public function unpack(bytes:ByteArray) : void
		{
			/*
			finish_info_num = bytes.readShort();
			
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			if (finish_info_num > 0)
			{
				var finishInfo:FinishInfo = _factory.createInstance(FinishInfo);
				finishInfo.unpack(bytes);
				
				finish_info_vec.push(finishInfo);
			}
			
			money.readFromBytes(bytes);
			*/
			
			super.unpack(bytes);
		}
		
		override public function dispose() : void
		{
			/*
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			for each(var item:FinishInfo in finish_info_vec)
			{
				item.dispose();
				_factory.destroyInstance(item);
			}
			
			finish_info_vec.length = 0;
			finish_info_num = 0;
			
			money.highPart = money.lowPart = 0;
			
			*/
			super.dispose();
		}
	}
}