package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	public class NotificationHandler_AnotherDesk extends NiuNotificationHandler
	{
		public function NotificationHandler_AnotherDesk(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			
		}
	}
}