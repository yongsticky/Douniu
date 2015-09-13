package server
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	
	import facade.NiuApplicationFacade;
	
	public class NiuServerConnectorMediator extends Mediator
	{
		public function NiuServerConnectorMediator(inner:PrivateInner)
		{
			super();
		}
		
		private static var _instance:NiuServerConnectorMediator = null;
		public static function instance() : NiuServerConnectorMediator
		{
			if (!_instance)
			{
				_instance = new NiuServerConnectorMediator(new PrivateInner());
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