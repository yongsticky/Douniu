package view.scene.table.layer
{
	import view.framework.ExLayer;
	import view.scene.table.widget.Widget_OtherPlayer;
	import view.scene.table.widget.Widget_Player;
	import view.scene.table.widget.Widget_RobButtonGroup;
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
								
				var player:Widget_Player = new Widget_Player();
				player.x = 120;
				player.y = stage.stageHeight - 220;
				addChild(player);
				
				createOtherPlayer(0);
				createOtherPlayer(1);
				createOtherPlayer(2);
				createOtherPlayer(3);
				createOtherPlayer(4);				
			}
			
			var robButtonGroup:Widget_RobButtonGroup = new Widget_RobButtonGroup();
			robButtonGroup.x = 280;
			robButtonGroup.y = stage.stageHeight - 270;
			addChild(robButtonGroup);
			
			var timer:Widget_Timer = new Widget_Timer(5);
			timer.x = 510;
			timer.y = 320;
			addChild(timer);
			
			timer.startTimer();
		}

		override protected function layoutChildren() : void
		{		
			super.layoutChildren();
		}
		
		public function createOtherPlayer(position:int) : void
		{
			var player:Widget_OtherPlayer = new Widget_OtherPlayer();
			
			switch(position)				
			{
			case 0:					
				player.x = 60;
				player.y = 350;
				break;
			case 1:
				player.x = 60;
				player.y = 150;
				break;
			case 2:
				player.x = 450;
				player.y = 100;
				break;
			case 3:
				player.x = 820;
				player.y = 160;
				break;
			case 4:
				player.x = 820;
				player.y = 350;
				break;				
			}
			
			addChild(player);		
		}
	}
}