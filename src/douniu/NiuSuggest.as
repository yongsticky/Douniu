package douniu
{
	import flash.utils.ByteArray;

	public class NiuSuggest
	{
		public function NiuSuggest()
		{
		}

		private static const SEQUENCE_ENUM:Array = 
		[
			[[0, 1],[2, 3, 4]],
			[[0, 2],[1, 3, 4]],
			[[0, 3],[1, 2, 4]],
			[[0, 4],[1, 2, 3]],
			[[1, 2],[0, 3, 4]],
			[[1, 3],[0, 2, 4]],
			[[1, 4],[0, 2, 3]],
			[[2, 3],[0, 1, 4]],
			[[2, 4],[0, 1, 3]],
			[[3, 4],[0, 1, 2]]
		];


		public static function getSuggestObject(tiles:ByteArray) : Object
		{
			var result:Object = {};

			// 先看下是否是特殊的牌型			
			var vs:int = NiuType.verifySpecial(tiles);
			if (vs != NiuType.NIU_ERROR)
			{				
				result.niuType = vs;
				result.cardSequence = new <int>[0, 1, 2, 3, 4];

				return result;
			}

			// 先计算一下，如果有牛的话，是牛几
			var sum:int = 0;
			for (var i:int = 0; i < tiles.length; ++i)
			{			
				sum += NiuCard.getValue(tiles[i]);			
			}
			sum %= 10;

			// 穷举排列	
			for each(var seq:Array in SEQUENCE_ENUM)
			{
				var sum2:int = (NiuCard.getValue(tiles[seq[0][0]]) + NiuCard.getValue(tiles[seq[0][1]])) % 10;
				if (sum == sum2)
				{
					var sum3:int = (NiuCard.getValue(tiles[seq[1][0]]) + NiuCard.getValue(tiles[seq[1][1]]) + NiuCard.getValue(tiles[seq[1][2]])) % 10;
					sum3 %= 10;
					if (sum3 == 0)
					{						
						result.niuType = (sum==0 ? NiuType.NIU_10:sum);
						var seqence:Vector.<int> = new <int>[seq[1][0], seq[1][1], seq[1][2], seq[0][0], seq[0][1]];												
						result.cardSequence = seqence;

						return result;
					}
				}
				else
				{
					continue;
				}
			}

			// 没有牛
			result.niuType = NiuType.NIU_0;
			result.cardSequence = new <int>[0, 1, 2, 3, 4];
			return result;

		}


		public static function getNiuTypeFromSuggestObject(obj:Object) : int
		{
			if (obj)
			{
				return obj.niuType;
			}
			else
			{
				return -1;
			}
		}


		public static function getCardSequenceFormSuggestObject(obj:Object) : Vector.<int>
		{
			if (obj)
			{
				return obj.cardSequence;
			}
			else
			{
				return null;
			}

		}
	}
}