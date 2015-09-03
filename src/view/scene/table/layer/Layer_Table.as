package view.scene.table.layer
{
	import view.framework.ExLayer;
	import view.scene.table.widget.Widget_OtherPlayer;
	import view.scene.table.widget.Widget_Player;
	import view.scene.table.widget.Widget_Timer;

	public class Layer_Table extends ExLayer
	{		
		private static const MAX_OTHER_PLAYER_NUM:int = 5;
		
		public function Layer_Table() 
		{
			super();			
		}
		
		override protected function createChildren() : void
		{			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; i++)
			{
				var otherPlayer:Widget_OtherPlayer = new Widget_OtherPlayer();
				
				if (i == 0)
				{					
					otherPlayer.x = 60;
					otherPlayer.y = 150;
					addChild(otherPlayer);
				}
				
				if (i == 1)
				{
					otherPlayer.x = 60;
					otherPlayer.y = 350;
					addChild(otherPlayer);
				}
				
				if (i == 2)
				{
					otherPlayer.x = 820;
					otherPlayer.y = 160;
					addChild(otherPlayer);
				}
				
				if (i == 3)
				{
					otherPlayer.x = 820;
					otherPlayer.y = 350;
					addChild(otherPlayer);
				}
				
				if (i == 4)
				{
					otherPlayer.x = 450;
					otherPlayer.y = 100;
					addChild(otherPlayer);
				}
				
				var player:Widget_Player = new Widget_Player();
				player.x = 120;
				player.y = stage.stageHeight - 220;
				addChild(player);
				
				
				var timer:Widget_Timer = new Widget_Timer(5);
				timer.x = 510;
				timer.y = 320;
				addChild(timer);
				
				timer.startTimer();
			}
		}

		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}