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
	import view.scene.huanle.layer.Layer_HuanleMain;
	import view.scene.table.layer.Layer_TableBottom;
	
	public class Scene_HuanLeTable extends ExScene
	{
		protected var _bg:ExImage;				
		protected var _quit:Button;
		
		public static const LAYER_MAIN:String = "layer.huanle.main";
		
		
		public function Scene_HuanLeTable(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			var resManager:ResManager = ResManager.instance();			
			
			_bg = new ExImage(resManager.getResource("ui.table_bg"));
			addChild(_bg);
			
			addChild(new Layer_TableBottom());
			
			_quit = new Button(Texture.fromBitmapData(resManager.getResource("ui.button_quit")));
			_quit.addEventListener(Event.TRIGGERED, onQuit);
			addChild(_quit);
						
			
			addChild(new Layer_HuanleMain(LAYER_MAIN));
		}	
		
		override protected function layoutChildren() : void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
						
			
			_quit.x = stage.stageWidth - _quit.width - 10;
			_quit.y = 10;
			
			super.layoutChildren();
		}
		
		private function onQuit(event:Event):void
		{			
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().sendNotification(NiuNotificationHandlerConstant.USER_LOGOUT);
		}
	}
}