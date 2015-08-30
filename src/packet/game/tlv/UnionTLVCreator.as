package packet.game.tlv
{	
	import camu.object.IObjectCreator;
	
	import factory.NiuObjectFactory;
	
	public class UnionTLVCreator implements IObjectCreator
	{
		public function UnionTLVCreator()
		{
		}
		
		// data = TLVValue Class
		public function createObject(cls:Class, data:*):*
		{
			return new UnionTLV();
		}
		
		// data = TLVValue Class
		
		public function onCreated(obj:*, data:*):void
		{	
			var uTLV:UnionTLV = obj as UnionTLV;
			if (uTLV)
			{
				uTLV.value = NiuObjectFactory.instance().createInstance(data as Class);
			}
			else
			{
				throw new Error("NOT UnionTLV Class!");
			}							 		
		}
		
		public function destoryObject(obj:*):void
		{
		}
		
		public function onDestroy(obj:*):void
		{	
			var uTLV:UnionTLV = obj as UnionTLV;
			if (uTLV)
			{
				NiuObjectFactory.instance().destroyInstance(uTLV.value);
				uTLV.value = null;
				uTLV.valueType = 0;
			}
			else
			{
				throw new Error("NOT UnionTLV Class!");
			}
			
			
		}
	}
}