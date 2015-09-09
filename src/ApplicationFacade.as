package 
{
	import camu.mvc.Facade;
	
	public class ApplicationFacade extends Facade
	{
		public function ApplicationFacade(inner:PrivateInner)
		{
			super();
		}
		
		private static var _instance:ApplicationFacade;
		public static function instance() : ApplicationFacade
		{
			if (!_instance)
			{
				_instance = new ApplicationFacade(new PrivateInner());
			}
			
			return _instance;
		}
	}
}

class PrivateInner
{
	
}