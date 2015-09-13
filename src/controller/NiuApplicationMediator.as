package controller
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	import facade.NiuApplicationFacade;
	
	public class NiuApplicationMediator extends Mediator
	{
		public function NiuApplicationMediator()
		{
			super();
		}
		
		override protected function getFacade() : Facade
		{
			return NiuApplicationFacade.instance() as Facade;
		}
	}
}