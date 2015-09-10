package controller 
{
	import camu.mvc.Facade;
	
	import controller.handler.NotificationHandler_ClickRoom;
	
	public class NiuApplicationFacade extends Facade
	{
		public function NiuApplicationFacade(inner:PrivateInner)
		{
			super();
		}
		
		private static var _instance:NiuApplicationFacade;
		public static function instance() : NiuApplicationFacade
		{
			if (!_instance)
			{
				_instance = new NiuApplicationFacade(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function initializeController() : void
		{
			registerHandler(HandlerName.CLICK_ROOM, new NotificationHandler_ClickRoom());
		}
	}
}

class PrivateInner
{
	
}