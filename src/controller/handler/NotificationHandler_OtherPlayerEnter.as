package controller.handler
{	
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;	

	public class NotificationHandler_OtherPlayerEnter extends NiuNotificationHandler
	{
		private var _count:int = 0;
		public function NotificationHandler_OtherPlayerEnter(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			
		}	
	}
}