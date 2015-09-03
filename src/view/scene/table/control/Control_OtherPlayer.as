package view.scene.table.control
{
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Control_OtherPlayer extends ExSprite
	{		
		private var _playerInfo:Control_PlayerInfo;
		
		private var _cards:Control_OtherPlayerCards;
		private var _robStatus:ExImage;
		private var _robMultiple:ExImage;
		
		
		public function Control_OtherPlayer()
		{
			super();
			
			
		}
		
		override protected function createChildren() : void
		{	
			_cards = new Control_OtherPlayerCards();		
			_cards.x = 120;
			_cards.y = 30;
			addChild(_cards);
			
			_playerInfo = new Control_PlayerInfo();
			addChild(_playerInfo);
		}

		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}