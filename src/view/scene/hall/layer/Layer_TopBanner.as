package view.scene.hall.layer
{			
	import resource.ResManager;
	
	import sound.SoundManager;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.NiuDirector;
	import view.framework.ExImage;
	import view.framework.ExLayer;
	import view.scene.mall.Scene_Mall;
	import view.scene.setting.Scene_Setting;
	import view.widget.Widget_TextMarquee;
	
	public class Layer_TopBanner extends ExLayer
	{
		private var _userIcon:ExImage;
				
		private var _nameIcon:ExImage;		
		private var _nameText:TextField;
		
		private var _coinIcon:ExImage;		
		private var _coinText:TextField;
		
		private var _ticketIcon:ExImage;		
		private var _ticketText:TextField;
				
		private var _notifyText:TextField;
		
		private var _settingBtn:Button;
		private var _vipMallBtn:Button;	
		
		private var _marquee:Widget_TextMarquee;
		
		
		public function Layer_TopBanner(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_userIcon = new ExImage(resManager.getResource("hall.user.png"));
			_userIcon.x = 50;
			_userIcon.y = 4;
			addChild(_userIcon);
			
			_nameIcon = new ExImage(resManager.getResource("hall.name.png"));
			_nameIcon.x = _userIcon.x + _userIcon.width + 8;
			_nameIcon.y = 12;
			addChild(_nameIcon);
			
						
			_nameText = new TextField(160, 24, "绝对的河蟹", "", 12, 0xFFFFFF, true);
			_nameText.hAlign = "left";
			_nameText.x = _nameIcon.x + _nameIcon.width + 10;
			_nameText.y = _nameIcon.y;
			_nameText.addChild(new Quad(160, 24, 0xCC6A29));
			addChild(_nameText);
			
			_coinIcon = new ExImage(resManager.getResource("hall.chips.png"));
			_coinIcon.x = _nameIcon.x;
			_coinIcon.y = _nameIcon.y + _nameIcon.height + 16;			
			addChild(_coinIcon);
			
			
			
			_coinText = new TextField(60, 24, "41922", "", 12, 0xFFFFFF, true);
			_coinText.hAlign = "left";
			_coinText.x = _nameText.x;
			_coinText.y = _coinIcon.y;
			_coinText.addChild(new Quad(60, 24, 0x5B504A));
			addChild(_coinText);
			
			
			_ticketIcon = new ExImage(resManager.getResource("hall.ticket.png"));
			_ticketIcon.x = _coinText.x + _coinText.width + 30;
			_ticketIcon.y = _coinIcon.y + 2;
			addChild(_ticketIcon);
						
			_ticketText = new TextField(40, 24, "820", "", 12, 0xFFFFFF, true);
			_ticketText.hAlign = "left";
			_ticketText.x = _ticketIcon.x + _ticketIcon.width + 10;
			_ticketText.y = _coinIcon.y;
			_ticketText.addChild(new Quad(40, 24, 0x5B504A));
			addChild(_ticketText);	
			
					
			/*
			_notifyText = new TextField(340, 34, "通知：你的好友XXXXXX在欢乐牛牛中的排名超过了你。", "", 12, 0xFFFFFF, false);
			_notifyText.hAlign = "left";
			_notifyText.x = _nameText.x + _nameText.width + 60;
			_notifyText.y = _nameText.y + 15;			
			_notifyText.addChild(new Quad(340, 34, 0xB37D57));
			addChild(_notifyText);			
			*/
			
			
			_marquee = new Widget_TextMarquee(340, 34);
			_marquee.x = _nameText.x + _nameText.width + 60;
			_marquee.y = _nameText.y + 15;
			addChild(_marquee);
			
			_marquee.add("通知：Lisa生日快乐！！。");
			_marquee.add("通知：Lisa Lisa Lisa！");
			_marquee.add("通知：Lisa和我的年龄差距最小的时刻！");
			
			
			_settingBtn = new Button(Texture.fromBitmapData(resManager.getResource("hall.setting.png")));
			_settingBtn.x = stage.stageWidth - _settingBtn.width - 50;
			_settingBtn.y = _nameText.y + 6;
			addChild(_settingBtn);
			_settingBtn.addEventListener(Event.TRIGGERED, onSettingTriggered);
			
			_vipMallBtn = new Button(Texture.fromBitmapData(resManager.getResource("hall.vip_mall.png")), 
									"", null, Texture.fromBitmapData(resManager.getResource("hall.vip_mall_hover.png")));
			_vipMallBtn.x = stage.stageWidth - _vipMallBtn.width - 20;
			_vipMallBtn.y = this.height + 10;
			addChild(_vipMallBtn);
			_vipMallBtn.addEventListener(Event.TRIGGERED, onVipMallTriggered);
		}
				
		protected function onSettingTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().pushScene(new Scene_Setting());			
		}
		
		protected function onVipMallTriggered(event:Event) : void
		{	
			SoundManager.instance().playButtonClick();
			
			NiuDirector.instance().pushScene(new Scene_Mall());
		}
	}
}