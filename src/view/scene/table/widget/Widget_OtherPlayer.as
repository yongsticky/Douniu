package view.scene.table.widget
{
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_OtherPlayer extends ExSprite
	{		
		private var _playerInfo:Widget_PlayerInfo;
		
		private var _cards:Widget_OtherPlayerCards;
		private var _robStatus:ExImage;
		private var _robMultiple:ExImage;
		
		
		public function Widget_OtherPlayer(name:String = null)
		{
			super(name);
			
			
		}
		
		override protected function createChildren() : void
		{	
			_cards = new Widget_OtherPlayerCards();		
			_cards.x = 120;
			_cards.y = 30;
			addChild(_cards);
			
			_playerInfo = new Widget_PlayerInfo();
			addChild(_playerInfo);
		}

		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}