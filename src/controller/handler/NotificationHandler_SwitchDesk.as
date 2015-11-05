package controller.handler
{
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	public class NotificationHandler_SwitchDesk extends NiuNotificationHandler
	{
		public function NotificationHandler_SwitchDesk(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			
		}
	}
}