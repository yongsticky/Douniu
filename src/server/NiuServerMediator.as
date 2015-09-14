package server
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	
	import controller.NiuNotification;
	
	import facade.NiuApplicationFacade;
	
	public class NiuServerMediator extends Mediator
	{
		public function NiuServerMediator(inner:PrivateInner)
		{
			super();
		}
		
		private static var _instance:NiuServerMediator = null;
		public static function instance() : NiuServerMediator
		{
			if (!_instance)
			{
				_instance = new NiuServerMediator(new PrivateInner());
			}
			
			return _instance;
		}
		
		override protected function getFacade() : Facade
		{
			return NiuApplicationFacade.instance() as Facade;
		}		
	}
}

class PrivateInner
{
	
}