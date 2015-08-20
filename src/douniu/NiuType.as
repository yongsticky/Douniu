package douniu
{
	public class NiuType
	{
		public static const NIU_ERROR:int = -1;			// error

		public static const NIU_0:int = 0;				// 无牛

		public static const NIU_1:int = 1;
		public static const NIU_2:int = 2;
		public static const NIU_3:int = 3;
		public static const NIU_4:int = 4;
		public static const NIU_5:int = 5;
		public static const NIU_6:int = 6;
		public static const NIU_7:int = 7;
		public static const NIU_8:int = 8;
		public static const NIU_9:int = 9;
		public static const NIU_10:int = 10;			// 牛牛
		
		public static const NIU_SILVER:int = 11;		// 银牛
		public static const NIU_GOLD:int = 12;			// 金牛
		public static const NIU_LITTLE:int = 13;		// 五小
		public static const NIU_BOMB:int = 14;			// 炸弹


		public function NiuType()
		{
		}

		public static function verifyNormal(cards:Vector.<NiuCard>) : int
		{			
			if (!cards || cards.length != 5)
			{
				return NIU_ERROR;
			}

			if (cards.every(function (item:NiuCard, idx:int, ar:Vector.<NiuCard>) : Boolean {
				return item;
				}))
			{
				return NIU_ERROR;
			}
	
			var result:int = cards[0].value + cards[1].value + cards[2].value;
			if (result%10 != 0)
			{
				return NIU_0;
			}
			else
			{
				result = cards[3].value + cards[4].value;

				return result>10 ? (result-10):result;
			}
			
			return NIU_ERROR;
			
		}

		public static function verifySpecial(cards:Vector.<NiuCard>) : int
		{
			if (!cards || cards.length != 5)
			{
				return NIU_ERROR;
			}

			if (cards.every(function (item:NiuCard, idx:int, ar:Vector.<NiuCard>) : Boolean {
				return item;
				}))
			{
				return NIU_ERROR;
			}

			var isSilver:Boolean = true;
			var isGold:Boolean = true;
			var isLittle:Boolean = true;
			var isBomb:Boolean = true;

			var sum:int = 0;
			var c0:int = cards[0].number;
			var c1:int = -1;
			for (var c:NiuCard in cards)
			{
				if (isSilver)
				{
					if (c.number < NiuCard.NUMBER_10)
					{
						isSilver = false;
						isGold = false;
					}
				}

				if (isGold)
				{
					if (c.number < NiuCard.NUMBER_J)
					{					
						isGold = false;
					}	
				}

				if (isLittle)
				{
					sum += c.value;
					if (sum > 10)
					{
						isLittle = false;
					}
				}

				
				if (isBomb)
				{
					if (c.number != c0 && c.number != c1)
					{
						if (c1 != -1)
						{
							isBomb = false;
						}
						else
						{
							c1 = c.number;
						}
					}
				}				
			}

			if (isBomb)
			{
				return NIU_BOMB;
			}

			if (isLittle)
			{
				return NIU_LITTLE;
			}

			if (isGold)
			{
				return NIU_GOLD;
			}

			if (isSilver)
			{
				return NIU_SILVER;
			}
			
			return NIU_ERROR;
		}
	}
}