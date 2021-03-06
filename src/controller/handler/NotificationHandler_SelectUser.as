package controller.handler
{
	import camu.logger.LEVEL;
	import camu.mvc.Mediator;
	import camu.mvc.Notification;
	
	import controller.NiuNotificationHandler;
	
	import global.RuntimeExchangeData;
	import global.UserSettings;
	
	import sound.SoundManager;
	
	import view.NiuDirector;
	import view.scene.hall.Scene_Hall;	
	
	public class NotificationHandler_SelectUser extends NiuNotificationHandler
	{
		public function NotificationHandler_SelectUser(mediator:Mediator)
		{
			super(mediator);
		}
		
		override public function execute(notification:Notification):void
		{
			_logger.log(this, "execute Enter.", LEVEL.DEBUG);
			
			RuntimeExchangeData.instance().redPlayerData.uin = uint(notification.getData());
						
			
			_logger.log(this, "User select User:[", uint(notification.getData()), "]", LEVEL.INFO);
			
			
			NiuDirector.instance().switchToScene(new Scene_Hall());		
			
			
			if (!UserSettings.instance().backgroundMusicMute)
			{
				SoundManager.instance().playBgMusic();
			}
		}
	}
}