package view.scene.table.layer
{
	import douniu.NiuCard;
	
	import view.framework.ExLayer;
	import view.scene.table.widget.Widget_OtherPlayer;
	import view.scene.table.widget.Widget_Player;
	import view.scene.table.widget.Widget_Timer;

	public class Layer_GameTable extends ExLayer
	{		
		private static const MAX_OTHER_PLAYER_NUM:int = 5;
				
		private var _player:Widget_Player;
		private var _timer:Widget_Timer;
		
		public function Layer_GameTable(name:String = null) 
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{			
			_player = new Widget_Player();
			_player.visible = false;
			addChild(_player);
							
			_timer = new Widget_Timer();
			_timer.visible = false;			
			addChild(_timer);
					
		}
		
		override protected function layoutChildren() : void
		{			
			_player.x = 120;
			_player.y = stage.stageHeight - 260;
			
			_timer.x = 510;
			_timer.y = 320;
			
			super.layoutChildren();
		}
		
		
		
		public function showPlayer() : void
		{
			_player.visible = true;
			_player.playerHeader.visible = true;
			
			
			var vec:Vector.<NiuCard> = new Vector.<NiuCard>();
			vec.push(new NiuCard(17));
			vec.push(new NiuCard(22));
			vec.push(new NiuCard(32));
			vec.push(new NiuCard(15));
			vec.push(new NiuCard(8));
			
			_player.playerCards.setPokers(vec);
			
			_player.playerCards.visible = true;
		}
		
		public function showTimer(time:int) : void
		{
			_timer.visible = true;			
			_timer.startTimer(time);
		}
		
		public function addOtherPlayerAt(seat:int) : void
		{
			var player:Widget_OtherPlayer = new Widget_OtherPlayer();
			
			switch(seat)				
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