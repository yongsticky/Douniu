package controller
{
	import camu.mvc.Mediator;

	public class NiuNotificationHandler
	{
		protected var _mediator:Mediator;
		
		public function NiuNotificationHandler(mediator:Mediator)
		{
			_mediator = mediator;
		}
		
		public function get mediator() : Mediator
		{
			return _mediator;
		}
		
		protected function sendNotification(name:String, data:Object = null) : void
		{
			mediator.sendNotification(NiuNotification.createNotification(name, data));
		}
	}
}