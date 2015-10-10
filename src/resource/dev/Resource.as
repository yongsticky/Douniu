package resource.dev
{
	import flash.utils.Dictionary;
	
	import camu.errors.NullObjectError;

	public class Resource
	{
		protected var _res:Dictionary;
		
		public function Resource()
		{
			_res = new Dictionary();
		}
		
		public function getResource(id:String) : *
		{
			if (_res.hasOwnProperty(id))
			{
				return _res[id];
			}
			else
			{
				return null;
			}
		}
		
		protected function add(id:String, obj:*) : void
		{
			if (obj)
			{
				_res[id] = obj;	
			}
			else
			{
				throw new NullObjectError();
			}			
		}
	}
}