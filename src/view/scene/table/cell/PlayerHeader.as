package view.scene.table.cell
{
	import resource.ResManager;
	
	import starling.text.TextField;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class PlayerHeader extends ExSprite
	{	
		private var _name:TextField;
		private var _header:ExImage;		
		private var _coin:ExImage;
		private var _coinNum:TextField;
		
		private var _useName:Boolean;
		
		public function PlayerHeader(name:String = null, useName:Boolean = true)
		{
			super(name);
			
			_useName = useName;
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			if (_useName)
			{			
				_name = new TextField(60, 28, "");
				_name.x = 4;
				_name.y = -24;
				_name.fontName = "Microsoft YaHei";
				_name.color = 0xFFFFFF;
				addChild(_name);
			}
			
			_header = new ExImage(resManager.getResource("ui.player_header_icon"));					
			addChild(_header);
						
			_coin = new ExImage(resManager.getResource("ui.coin_with_bg"));
			_coin.y = _header.width + 4;
			addChild(_coin);
			
			_coinNum = new TextField(46, 20, "18000", "Microsoft YaHei", 12, 0xFDBC2A);
			_coinNum.x = 22;
			_coinNum.hAlign = "left";			
			_coin.addChild(_coinNum);
		}
		
		public function setPlayerInfo(nickName:String, money:int, headerIcon:int) : void
		{
			if (_name && nickName)
			{
				_name.text = nickName;
			}
			
			if (money)
			{
				_coinNum.text = money.toString();
		
			}
			
			if (headerIcon)
			{
				
			}
		}
	}
}