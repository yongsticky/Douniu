package view.scene.selectuser.layer
{	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import facade.NiuNotificationHandlerConstant;	
	import resource.ResManager;	
	import sound.SoundManager;	
	import view.NiuDirector;
	import view.framework.ExLayer;
	
	public class Layer_SelectUserMain extends ExLayer
	{
				
		public function Layer_SelectUserMain(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var texture:Texture = Texture.fromBitmapData(ResManager.instance().getResource("ui.player_header_icon"));
			var startX:int = 200;
			for (var i:int = 0; i < 6; i++)
			{
				var usr:Button = new Button(texture, "3000000"+(i+1).toString());				
				usr.fontColor = 0xFF;
				usr.fontSize = 18;
				usr.x = startX;
				usr.y = (stage.height - usr.height) >> 1;
				addChild(usr);
				
				usr.addEventListener(Event.TRIGGERED, onTriggered);
				
				startX += usr.width + 20;
			}
		}
		
		protected function onTriggered(event:Event) : void
		{
			SoundManager.instance().playButtonClick();
			
			var btn:Button = event.target as Button;			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.SELECT_USER, int(btn.text));
		}
	}
}