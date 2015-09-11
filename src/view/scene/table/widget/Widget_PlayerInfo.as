package view.scene.table.widget
{
	import resource.ResManager;
	
	import starling.text.TextField;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_PlayerInfo extends ExSprite
	{
		private var _playerName:TextField;
		private var _playerIcon:ExImage;
		private var _chips:TextField;
		
		
		public function Widget_PlayerInfo(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();
			
			_playerName = new TextField(117, 25, "绝对的河蟹", "", 12, 0xFFFFFF);			
			addChild(_playerName);
			
			_playerIcon = new ExImage(resManager.getResourceDev("hall.user"));
			_playerIcon.x = 20;
			_playerIcon.y = 24;			
			addChild(_playerIcon);			
			
			_chips = new TextField(117, 25, "10000", "", 12, 0xFFFFFF);
			_chips.y = _playerIcon.y + _playerIcon.height + 2;
			_chips.addChild(new ExImage(resManager.getResourceDev("table.chips")));
			addChild(_chips);
		}
		
		override protected function layoutChildren() : void
		{
			
		}
	}
}