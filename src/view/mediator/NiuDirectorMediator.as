package view.mediator
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	import facade.NiuApplicationFacade;
	
	public class NiuDirectorMediator extends Mediator
	{
		public function NiuDirectorMediator()
		{
			super();
		}
		
		override protected function getFacade() : Facade
		{
			return NiuApplicationFacade.instance() as Facade;	
		}		
	}
}