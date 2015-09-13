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
		
		private static const OTHER_PLAYER_SEAT_POSISTION:Array = [{"x":60, "y":360}, {"x":60, "y":180}, {"x":480, "y":60}, {"x":820, "y":180}, {"x":820, "y":360}];
		
		private var _player:Widget_Player;
		private var _timer:Widget_Timer;
		private var _otherPlayers:Vector.<Widget_OtherPlayer>;
		
		
		
		public function Layer_GameTable(name:String = null) 
		{
			super(name);
			
			_otherPlayers = new Vector.<Widget_OtherPlayer>(MAX_OTHER_PLAYER_NUM);
		}
		
		override protected function createChildren() : void
		{			
			_player = new Widget_Player();
			_player.visible = false;
			addChild(_player);
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				var other:Widget_OtherPlayer = new Widget_OtherPlayer(i);
				_otherPlayers[i] = other;				
				
				other.visible = false;				
				addChild(other);				
			}
							
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
			
			for (var i:int = 0; i < MAX_OTHER_PLAYER_NUM; ++i)
			{
				var other:Widget_OtherPlayer = _otherPlayers[i];
				other.x = OTHER_PLAYER_SEAT_POSISTION[i]["x"];
				other.y = OTHER_PLAYER_SEAT_POSISTION[i]["y"];
			}
			
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
		
		public function showOtherPlayer(seat:int, show:Boolean = true) : void
		{
			var vec:Vector.<NiuCard> = new Vector.<NiuCard>();
			vec.push(new NiuCard(17));
			vec.push(new NiuCard(22));
			vec.push(new NiuCard(32));
			vec.push(new NiuCard(15));
			vec.push(new NiuCard(8));
			
			if (seat >=0 && seat < MAX_OTHER_PLAYER_NUM)
			{
				var other:Widget_OtherPlayer = _otherPlayers[seat];
												
				other.visible = show;
				other.playerHeader.visible = show;
				other.playerCards.visible = show;
				
				
				if (seat == 2)
				{
					other.playerCards.setPokers(vec);
				}
				else
				{
					other.playerCards.setPokers(null);
				}
				
			}
		}	
	}
}