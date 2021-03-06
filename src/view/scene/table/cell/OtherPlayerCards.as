package view.scene.table.cell
{
	import flash.utils.ByteArray;
	
	import camu.errors.NullObjectError;
	import camu.errors.UnexpectedLengthError;
	
	import douniu.NiuCard;
	
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class OtherPlayerCards extends ExSprite
	{		
		private static const MAX_POKER_NUM:int = 5;
		
		private var COLOR_TO_STR:Array = ["hei", "hong", "mei", "fang"];
		
		private var _pokers:Vector.<ExImage>;
		
		public function OtherPlayerCards(name:String = null)
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
				
				startX += 18;
			}
		}
		
		public function setPokers(tiles:ByteArray) : void
		{
			if (!tiles)
			{
				throw new NullObjectError();
			}
			
			if (tiles.length != MAX_POKER_NUM)
			{
				throw new UnexpectedLengthError();
			}
			
			var maxIndex:int = tiles.length;			
			for (var i:int = 0; i < maxIndex; ++i)
			{
				var cI:ExImage = _pokers[i];
				cI.res = getPokerResource(tiles[i]);
			}
		}
		
		public function setPokersNull() : void
		{
			for (var i:int = 0; i < MAX_POKER_NUM; ++i)
			{
				_pokers[i].res = getPokerResource(0);
			}
		}
		
		private function getPokerResource(c:int) : *
		{
			var res:*;
			if (c > 0)
			{
				res = ResManager.instance().getResource("poker." + COLOR_TO_STR[NiuCard.getColor(c)] + "_" + NiuCard.getNumber(c).toString());
			}
			else
			{
				res = ResManager.instance().getResource("poker.bei");
			}
			
			return res;
		}
	}
}