package controller
{
	import camu.errors.AbstractFunctionError;
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	import camu.mvc.interfaces.INotificationHandler;

		public class NiuNotificationHandler implements INotificationHandler
	{
		protected var _logger:ILogger;
		protected var _mediator:Mediator;
		
		public function NiuNotificationHandler(mediator:Mediator)
		{
			_mediator = mediator;
			
			_logger = Logger.createLogger(NiuNotificationHandler, LEVEL.DEBUG);
		}
		
		public function get mediator() : Mediator
		{
			return _mediator;
		}
		
		public function execute(notification:Notification) : void
		{
			throw new AbstractFunctionError();			
		}
		
		protected function sendNotification(name:String, data:Object = null) : void
		{
			mediator.sendNotification(NiuNotification.createNotification(name, data));
		}
	}
}