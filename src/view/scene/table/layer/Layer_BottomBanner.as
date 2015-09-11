package view.scene.table.layer
{
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.framework.ExImage;
	import view.framework.ExLayer;
	
	public class Layer_BottomBanner extends ExLayer
	{
		private var _bg:ExImage;
		private var _name:TextField;
		private var _vipMall:Button;
		
		public function Layer_BottomBanner(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_bg = new ExImage(resManager.getResourceDev("table.bottom_banner"));
			_bg.y = stage.stageHeight - _bg.height;
			_bg.width = stage.width;
			addChild(_bg);
			
			_name = new TextField(150, 24, "绝对的河蟹: 1000金币", "", 14, 0xFFFFFF, true);
			_name.x = 20;
			_name.y = _bg.y + ((_bg.height - _name.height) >> 1);
			addChild(_name);
			
			_vipMall = new Button(Texture.fromBitmapData(resManager.getResourceDev("table.vip_mall")), "");
			_vipMall.x  = _bg.width - _vipMall.width - 10;
			_vipMall.y = _bg.y + ((_bg.height - _vipMall.height)>>1);;
			addChild(_vipMall);
			
		}

		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}