package view.scene.table.widget
{
	import view.framework.ExSprite;
	
	public class Widget_Player extends ExSprite
	{
		private var _playerInfo:Widget_PlayerInfo;
		private var _playerCards:Widget_PlayerCards;
		
		
		public function Widget_Player(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			_playerInfo = new Widget_PlayerInfo();
			addChild(_playerInfo);
			
			_playerCards = new Widget_PlayerCards();
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