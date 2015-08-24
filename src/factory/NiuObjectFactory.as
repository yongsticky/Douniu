package factory
{
	import camu.object.BaseObjectFactory;
	import camu.object.IObjectCache;
	
	public class NiuObjectFactory extends BaseObjectFactory
	{
		public function NiuObjectFactory(objCache:IObjectCache = null)
		{
			super(objCache);
		}
	}
}