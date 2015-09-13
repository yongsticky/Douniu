package view.scene.table.widget
{
	import douniu.NiuCard;
	
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_OtherPlayerCards extends ExSprite
	{		
		private static const MAX_CARDS_NUM:int = 5;
		
		private var COLOR_TO_STR:Array = ["hei", "hong", "mei", "fang"];
		
		private var _pokers:Vector.<ExImage>;
		
		public function Widget_OtherPlayerCards(name:String = null)
		{
			super(name);
			
			_pokers = new Vector.<ExImage>(MAX_CARDS_NUM);
		}
		
		override protected function createChildren() : void
		{			
		}
		
		public function setPokers(cards:Vector.<NiuCard>) : void
		{			
			var maxCount:int = (cards&&cards.length<MAX_CARDS_NUM) ? cards.length:MAX_CARDS_NUM;
			var resManager:ResManager = ResManager.instance();
						
			var startX:int = 0;
			for (var i:int = 0; i < MAX_CARDS_NUM; i++)
			{				
				var c:ExImage = new ExImage(getPokerResource(cards ? cards[i]:null));
				c.y = 0;
				c.x = startX;
				addChild(c);
				
				if (i == 2 && cards && cards[i])
				{
					startX += 16;
				}
				
				startX += 16;
			}			
		}
		
		private function getPokerResource(card:NiuCard) : *
		{
			var res:*;
			if (card)
			{
				res = ResManager.instance().getResourceDev("poker." + COLOR_TO_STR[card.color] + "." + card.number.toString());
			}
			else
			{
				res = ResManager.instance().getResourceDev("poker.bei");
			}
			
			return res;
		}
	}
}