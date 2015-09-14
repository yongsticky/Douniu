package view.scene.table.widget
{
	import resource.ResManager;
	
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_PlayerHeader extends ExSprite
	{
		private var _playerName:TextField;
		private var _playerIcon:ExImage;
		private var _chips:TextField;
		
		
		public function Widget_PlayerHeader(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_playerName = new TextField(117, 25, "N/A", "", 12, 0xFFFFFF);			
			addChild(_playerName);
			
			_playerIcon = new ExImage(resManager.getResourceDev("hall.user"));
			_playerIcon.x = 20;
			_playerIcon.y = 24;			
			addChild(_playerIcon);			
			
			_chips = new TextField(117, 25, "0", "", 12, 0xFFFFFF);
			_chips.y = _playerIcon.y + _playerIcon.height + 2;
			_chips.addChild(new ExImage(resManager.getResourceDev("table.chips")));
			addChild(_chips);
		}
		
		public function setPlayerInfo(nick:String, chips:int, header:int) : void
		{
			if (nick)
			{
				_playerName.text = nick;
			}						
			
			if (chips)
			{
				_chips.text = chips.toString();
			}
		}
	}
}