package view.mediator
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	import facade.NiuApplicationFacade;
	
	public class NiuViewMediator extends Mediator
	{
		public function NiuViewMediator()
		{
			super();
		}
		
		override protected function getFacade() : Facade
		{
			return NiuApplicationFacade.instance() as Facade;	
		}		
	}
}