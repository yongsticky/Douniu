package view.scene.huanle
{
	import facade.NiuNotificationHandlerConstant;
	
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.huanle.layer.Layer_Main;
	
	public class Scene_HuanLeTable extends ExScene
	{
		protected var _bg:ExImage;
		protected var _logo:ExImage;
		
		protected var _exitButton:Button;
		
		public static const LAYER_MAIN:String = "main_layer";
		
		
		public function Scene_HuanLeTable(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			var resManager:ResManager = ResManager.instance();			
			
			_bg = new ExImage(resManager.getResource("table.bg.png"));
			addChild(_bg);
			
			_logo = new ExImage(resManager.getResource("table.bg_logo.png"));			
			_logo.alpha = 0.1;
			addChild(_logo);
			
			_exitButton = new Button(Texture.fromColor(60, 40, 0xFFFF0000), "退出>>");
			_exitButton.addEventListener(Event.TRIGGERED, onTriggered);			
			addChild(_exitButton);
			
			addChild(new Layer_Main(LAYER_MAIN));
		}
		
		private function onTriggered(event:Event):void
		{			
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.USER_LOGOUT);
		}
		
		override protected function layoutChildren() : void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
			
			_logo.x = (stage.stageWidth - _logo.width) >> 1;
			_logo.y = (stage.stageHeight - _logo.height) >> 1;
			
			_exitButton.x = stage.stageWidth - _exitButton.width - 10;
			_exitButton.y = 10;
			
			super.layoutChildren();
		}
	}
}