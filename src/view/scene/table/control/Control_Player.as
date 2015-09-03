package view.scene.table.control
{
	import view.framework.ExSprite;
	
	public class Control_Player extends ExSprite
	{
		private var _playerInfo:Control_PlayerInfo;
		private var _playerCards:Control_PlayerCards;
		
		
		public function Control_Player()
		{
			super();
		}
		
		override protected function createChildren() : void
		{
			_playerInfo = new Control_PlayerInfo();
			addChild(_playerInfo);
			
			_playerCards = new Control_PlayerCards();
			_playerCards.x = 220;
			_playerCards.y = 20;
			addChild(_playerCards);
		}
		
		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}