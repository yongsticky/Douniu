package controller
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	import facade.NiuApplicationFacade;
	
	public class NiuControllerMediator extends Mediator
	{
		public function NiuControllerMediator()
		{
			super();
		}
		
		override protected function getFacade() : Facade
		{
			return NiuApplicationFacade.instance() as Facade;
		}
	}
}