package server
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	
	import facade.NiuApplicationFacade;
	
	public class NiuServerMediator extends Mediator
	{
		public function NiuServerMediator()
		{
			super();
		}
		
		override protected function getFacade() : Facade
		{
			return NiuApplicationFacade.instance();	
		}
	}
}