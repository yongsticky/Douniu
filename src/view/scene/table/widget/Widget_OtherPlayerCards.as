package view.scene.table.widget
{
	import camu.errors.NullObjectError;
	import camu.errors.UnexpectedLengthError;
	
	import douniu.NiuCard;
	
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_OtherPlayerCards extends ExSprite
	{		
		private static const MAX_POKER_NUM:int = 5;
		
		private var COLOR_TO_STR:Array = ["hei", "hong", "mei", "fang"];
		
		private var _pokers:Vector.<ExImage>;
		
		public function Widget_OtherPlayerCards(name:String = null)
		{
			super(name);
			
			_pokers = new Vector.<ExImage>(MAX_POKER_NUM);
		}
		
		override protected function createChildren() : void
		{
			var startX:int = 0;
			for (var i:int = 0; i < MAX_POKER_NUM; ++i)
			{
				var cI:ExImage = new ExImage();
				cI.x = startX;
				cI.y = 0;
				addChild(cI);
				_pokers[i] = cI;
				
				startX += 16;
			}
		}
		
		public function setPokers(cards:Vector.<int>) : void
		{
			if (!cards)
			{
				throw new NullObjectError();
			}
			
			if (cards.length != MAX_POKER_NUM)
			{
				throw new UnexpectedLengthError();
			}
			
			var maxIndex:int = cards.length;
			
			for (var i:int = 0; i < maxIndex; ++i)
			{
				var cI:ExImage = _pokers[i];
				cI.res = getPokerResource(cards[i]);
			}
		}
		
		private function getPokerResource(c:int) : *
		{
			var res:*;
			if (c > 0)
			{
				res = ResManager.instance().getResource("poker." + COLOR_TO_STR[NiuCard.getColor(c)] + "_" + NiuCard.getNumber(c).toString() + ".png");
			}
			else
			{
				res = ResManager.instance().getResource("poker.bei.png");
			}
			
			return res;
		}
	}
}