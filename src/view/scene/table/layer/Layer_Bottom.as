package view.scene.table.layer
{
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;
	import view.scene.mall.Scene_Mall;	
	import view.scene.table.cell.PlayerInfo;
	
	public class Layer_Bottom extends ExLayer
	{
		private var _bg:ExImage;		
		private var _playerInfo:PlayerInfo;
		internal var _mall:Button;
		
		public function Layer_Bottom(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResource("ui.table_bottom_bg"));			
			addChild(_bg);
			
			_playerInfo = new PlayerInfo();
			addChild(_playerInfo);
			
			
			_mall = new Button(Texture.fromBitmapData(resManager.getResource("ui.button_vip_mall")));		
			addChild(_mall);
			_mall.addEventListener(Event.TRIGGERED, onMall);
		}
		
		override protected function layoutChildren() : void
		{
			_bg.width = stage.stageWidth;
			_bg.y = stage.stageHeight - _bg.height;
						
			_playerInfo.y = _bg.y;
			
			_mall.x  = _bg.width - _mall.width - 10;
			_mall.y = _bg.y + 4;
			
			super.layoutChildren();
		}
		
		private function onMall(event:Event):void
		{
			NiuDirector.instance().pushScene(new Scene_Mall());			
		}
	}
}