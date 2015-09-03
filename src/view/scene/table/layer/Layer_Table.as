package view.scene.table.layer
{
	import view.framework.ExLayer;
	import view.scene.table.control.Control_OtherPlayer;
	import view.scene.table.control.Control_Player;

	public class Layer_Table extends ExLayer
	{
		private var _otherPlayers:Vector.<Control_OtherPlayer>;
		private var _player:Control_Player;
		
		private static const MAX_OTHER_PLAYER_NUM:int = 5;
		
		public function Layer_Table() 
		{
			super();			
		}
		
		override protected function createChildren() : void
		{
			_otherPlayers = new Vector.<Control_OtherPlayer>();
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; i++)
			{
				_otherPlayers[i] = new Control_OtherPlayer();
				
				if (i == 0)
				{					
					_otherPlayers[i].x = 60;
					_otherPlayers[i].y = 150;
					addChild(_otherPlayers[i]);
				}
				
				if (i == 1)
				{
					_otherPlayers[i].x = 60;
					_otherPlayers[i].y = 350;
					addChild(_otherPlayers[i]);
				}
				
				if (i == 2)
				{
					_otherPlayers[i].x = 820;
					_otherPlayers[i].y = 160;
					addChild(_otherPlayers[i]);
				}
				
				if (i == 3)
				{
					_otherPlayers[i].x = 820;
					_otherPlayers[i].y = 350;
					addChild(_otherPlayers[i]);
				}
				
				if (i == 4)
				{
					_otherPlayers[i].x = 450;
					_otherPlayers[i].y = 100;
					addChild(_otherPlayers[i]);
				}
				
				_player = new Control_Player();
				_player.x = 120;
				_player.y = stage.stageHeight - 220;
				addChild(_player);
				
			}
		}

		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}