package factory
{
	import camu.object.DefaultObjectFactory;
	import camu.object.IObjectCache;
	
	public class NiuObjectFactory extends DefaultObjectFactory
	{
		public function NiuObjectFactory(objCache:IObjectCache = null)
		{
			super(objCache);
		}
	}
}