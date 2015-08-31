package view.scene.hall.layer
{	
	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.framework.ExImage;
	import view.framework.ExLayer;
	
	public class LayerContent extends ExLayer
	{
		private var _userIcon:ExImage;
				
		private var _nameIcon:ExImage;
		private var _nameQuad:Quad;
		private var _nameText:TextField;
		
		private var _coinIcon:ExImage;
		private var _coinQuad:Quad;
		private var _coinText:TextField;
		
		private var _ticketIcon:ExImage;
		private var _ticketQuad:Quad;
		private var _ticketText:TextField;
		
		private var _notifyQuad:Quad;
		private var _notifyText:TextField;
		
		private var _settingBtn:Button;
		private var _vipMallBtn:Button;
		
		
		
		public function LayerContent()
		{
			super();
		}		
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_userIcon = new ExImage(resManager.getResourceDev("hall.user"));
			_userIcon.x = 50;
			_userIcon.y = 4;
			addChild(_userIcon);
			
			_nameIcon = new ExImage(resManager.getResourceDev("hall.name"));
			_nameIcon.x = _userIcon.x + _userIcon.width + 8;
			_nameIcon.y = 12;
			addChild(_nameIcon);
			
			_nameQuad = new Quad(180, 24, 0xCC6A29);
			_nameQuad.x = _nameIcon.x + _nameIcon.width + 8;
			_nameQuad.y = _nameIcon.y;
			addChild(_nameQuad);
			
			_nameText = new TextField(160, 24, "绝对的河蟹", "", 12, 0xFFFFFF, true);
			_nameText.hAlign = "left";
			_nameText.x = _nameQuad.x + 10;
			_nameText.y = _nameQuad.y;
			addChild(_nameText);
			
			_coinIcon = new ExImage(resManager.getResourceDev("hall.coin"));
			_coinIcon.x = _nameIcon.x;
			_coinIcon.y = _nameIcon.y + _nameIcon.height + 16;
			addChild(_coinIcon);
			
			_coinQuad = new Quad(80, 24, 0x5B504A);
			_coinQuad.x = _nameQuad.x;
			_coinQuad.y = _coinIcon.y;
			addChild(_coinQuad);
			
			_coinText = new TextField(60, 24, "41922", "", 12, 0xFFFFFF, true);
			_coinText.hAlign = "left";
			_coinText.x = _coinQuad.x + 10;
			_coinText.y = _coinQuad.y;
			addChild(_coinText);
			
			_ticketIcon = new ExImage(resManager.getResourceDev("hall.ticket"));
			_ticketIcon.x = _coinQuad.x + _coinQuad.width + 12;
			_ticketIcon.y = _coinIcon.y + 2;
			addChild(_ticketIcon);
			
			_ticketQuad = new Quad(60, 24, 0x5B504A);
			_ticketQuad.x = _ticketIcon.x + _ticketIcon.width + 10;
			_ticketQuad.y = _coinQuad.y;
			addChild(_ticketQuad);
			
			_ticketText = new TextField(40, 24, "820", "", 12, 0xFFFFFF, true);
			_ticketText.hAlign = "left";
			_ticketText.x = _ticketQuad.x + 10;
			_ticketText.y = _ticketQuad.y;
			addChild(_ticketText);	
			
			_notifyQuad = new Quad(360, 34, 0xB37D57);
			_notifyQuad.x = _nameQuad.x + _nameQuad.width + 40;
			_notifyQuad.y = _nameQuad.y + 10;
			addChild(_notifyQuad);
			
			_notifyText = new TextField(340, 24, "通知：你的好友XXXXXX在欢乐牛牛中的排名超过了你。", "", 12, 0xFFFFFF, false);
			_notifyText.hAlign = "left";
			_notifyText.x = _notifyQuad.x + 10;
			_notifyText.y = _notifyQuad.y + 5;
			addChild(_notifyText);
			
			_settingBtn = new Button(Texture.fromBitmap(resManager.getResourceDev("hall.setting")));
			_settingBtn.x = stage.stageWidth - _settingBtn.width - 50;
			_settingBtn.y = _nameQuad.y + 6;
			addChild(_settingBtn);
			
			_vipMallBtn = new Button(Texture.fromBitmap(resManager.getResourceDev("hall.vipMall")), 
									"", null, Texture.fromBitmap(resManager.getResourceDev("hall.vipMall_h")));
			_vipMallBtn.x = stage.stageWidth - _vipMallBtn.width - 20;
			_vipMallBtn.y = this.height + 10;
			addChild(_vipMallBtn);
		}
	}
}