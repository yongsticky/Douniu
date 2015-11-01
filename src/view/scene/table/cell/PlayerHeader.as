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
		private var _coinText:TextField;
		
		public function PlayerHeader(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
						
					
			_header = new ExImage(resManager.getResource("ui.player_header_icon"));					
			addChild(_header);
						
			_coin = new ExImage(resManager.getResource("ui.coin_with_bg"));
			_coin.y = _header.width + 4;
			addChild(_coin);
			
			_coinText = new TextField(46, 20, "18000", "Microsoft YaHei", 12, 0xFDBC2A);
			_coinText.x = 22;
			_coinText.hAlign = "left";			
			_coin.addChild(_coinText);
		}
		
		public function setPlayerInfo(nick:String, chips:int, header:int) : void
		{			
		}
	}
}