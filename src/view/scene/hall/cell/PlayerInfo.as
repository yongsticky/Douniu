package view.scene.hall.cell
{
	import global.RuntimeExchangeData;
	import global.structs.REDPlayerData;
	
	import resource.ResManager;
	
	import starling.text.TextField;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class PlayerInfo extends ExSprite
	{		
		private var _header:ExImage;
		private var _name:TextField;
		private var _coinIcon:ExImage;
		private var _coinNum:TextField;
		private var _noteIcon:ExImage;
		private var _noteNum:TextField;
		
		
		public function PlayerInfo(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			var resManager:ResManager = ResManager.instance();
			var redp:REDPlayerData = RuntimeExchangeData.instance().redPlayerData;
			
			var header:int = 1 + (redp.uin % 6);
			_header = new ExImage(resManager.getResource("ui.header_"+header.toString()));
			_header.y = 2;
			_header.scaleX = _header.scaleY = 0.9;
			addChild(_header);
						
			_name = new TextField(160, 24, redp.nick, "Microsoft YaHei", 14, 0xFFFFFF);
			_name.hAlign = "left";
			_name.x = _header.x + _header.width + 10;
			_name.y = 4;
			addChild(_name);
			
			_coinIcon = new ExImage(resManager.getResource("ui.coin_icon"));
			_coinIcon.x = _name.x;
			_coinIcon.y = height/2 + 6;
			addChild(_coinIcon);
			
			_coinNum = new TextField(60, 24, redp.money.toString(), "Microsoft YaHei", 12, 0xFDBC2A);
			_coinNum.hAlign = "left";
			_coinNum.x = _coinIcon.x + _coinIcon.width + 2;
			_coinNum.y = _coinIcon.y;			
			addChild(_coinNum);
			
			_noteIcon = new ExImage(resManager.getResource("ui.note_icon"));
			_noteIcon.x = _coinNum.x + _coinNum.width + 2;
			_noteIcon.y = _coinIcon.y;
			addChild(_noteIcon);
			
			_noteNum = new TextField(40, 24, redp.note.toString(), "Microsoft YaHei", 12, 0xEF4848);
			_noteNum.hAlign = "left";
			_noteNum.x = _noteIcon.x + _noteIcon.width + 2;
			_noteNum.y = _noteIcon.y;
			addChild(_noteNum);			
		}
	}
}