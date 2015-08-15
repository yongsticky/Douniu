package douniu
{
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


		public static function getSuggestObject(cards:Vector.<NiuCard>) : Object
		{
			var result:Object = {};

			// 先看下是否是特殊的牌型			
			var vs:int = NiuType.verifySpecial(cards);
			if (vs != NiuType.NIU_ERROR)
			{				
				result.niuType = vs;
				result.cardSequence = new Vector.<int>([0, 1, 2, 3, 4]);

				return result;
			}

			// 先计算一下，如果有牛的话，是牛几
			var sum:int = 0;
			for (var c:NiuCard in cards)
			{
				if (c)
				{
					sum += c.value;
				}
				else
				{
					return null;
				}
			}
			sum %= 10;

			// 穷举排列	
			for (var seq:Array in SEQUENCE_ENUM)
			{
				var sum2:int = (cards[seq[0][0]].value+cards[seq[0][1]].value) % 10;
				if (sum == sum2)
				{
					var sum3:int = (cards[1][0].value+cards[1][1].value+cards[1][2].value) % 10;
					sum3 %= 10;
					if (sum3 == 0)
					{						
						result.niuType = ((!sum) ? sum:NiuType.NIU_10);
						var seqence:Vector.<int> = new Vector.<int>();
						seqence.push(seq[0][0]);
						seqence.push(seq[0][1]);
						seqence.push(seq[1][0]);
						seqence.push(seq[1][1]);
						seqence.push(seq[1][2]);
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
			result.cardSequence = new Vector.<int>([0, 1, 2, 3, 4]);
			return result;

		}


		public static function getNiuTypeFromSuggestObject(obj:Object) : int
		{
			if (!!obj)
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
			if (!!obj)
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