package view.mediator
{
	import camu.mvc.Facade;
	import camu.mvc.Mediator;
	
	public class NiuDirectorMediator extends Mediator
	{
		public function NiuDirectorMediator()
		{
			super();
		}
		
		override protected function getFacade() : Facade
		{
			return ApplicationFacade.instance() as Facade;	
		}
		
		
	}
}