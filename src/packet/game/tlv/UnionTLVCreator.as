package packet.game.tlv
{	
	import camu.object.IObjectCreator;
	
	import factory.NiuObjectFactory;
	
	import packet.game.tlv.value.TLVValue;
	
	public class UnionTLVCreator implements IObjectCreator
	{
		public function UnionTLVCreator()
		{
		}
		
		public function createObject(cls:Class, data:*):*
		{
			return null;
		}
		
		public function onCreated(obj:*, data:*):void
		{
			(obj as UnionTLV).value = data as  TLVValue;						
		}
		
		public function destoryObject(obj:*):void
		{
		}
		
		public function onDestroy(obj:*):void
		{			
			NiuObjectFactory.instance().destroyInstance((obj as UnionTLV).value);			
		}
	}
}