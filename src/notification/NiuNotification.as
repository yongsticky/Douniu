package notification
{
	import camu.mvc.Notification;
	import camu.object.interfaces.IObjectRecycled;
	
	import factory.NiuObjectFactory;
	
	public class NiuNotification extends Notification implements IObjectRecycled
	{
		public function NiuNotification(name:String, data:Object)
		{
			super(name, data);
		}
		
		public static function createNotification(name:String, data:Object) : NiuNotification
		{
			var obj:NiuNotification = NiuObjectFactory.instance().createInstance(NiuNotification);
			obj.setNotification(name, data);
			
			return obj;	
		}
		
		
		public function onObjectRecycled() : void
		{
			_name = null;
			_data = null;
		}
		
		internal function setNotification(name:String, data:Object) : void
		{
			setName(name);
			setData(data);
		}
	}
}