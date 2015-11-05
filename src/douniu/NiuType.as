package douniu
{
	import flash.utils.ByteArray;

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

		public static function verifyNormal(tiles:ByteArray) : int
		{			
			if (!tiles || tiles.length != 5)
			{
				return NIU_ERROR;
			}		
	
			var result:int = NiuCard.getValue(tiles[0]) + NiuCard.getValue(tiles[1]) + NiuCard.getValue(tiles[2]);
			if (result%10 != 0)
			{
				return NIU_0;
			}
			else
			{
				result = NiuCard.getValue(tiles[3]) + NiuCard.getValue(tiles[4]);

				return result>10 ? (result-10):result;
			}
			
			return NIU_ERROR;
			
		}

		public static function verifySpecial(tiles:ByteArray) : int
		{
			if (!tiles || tiles.length != 5)
			{
				return NIU_ERROR;
			}
			
			
			var arr:Array = new Array();
			arr.push(tiles[0]);
			arr.push(tiles[1]);
			arr.push(tiles[2]);
			arr.push(tiles[3]);
			arr.push(tiles[4]);
			arr.sort(Array.NUMERIC);
			if (arr[0] == arr[3] || arr[1] == arr[4])
			{
				return NIU_BOMB;
			}
			
			
			var isSilver:Boolean = true;
			var isGold:Boolean = true;
			var isLittle:Boolean = true;
			var sum:int = 0;
			var c:int = 0;
			for (var i:int = 0; i < tiles.length; ++i)
			{
				c = int(tiles[i]);
				if (isSilver)
				{
					if (NiuCard.getNumber(c) < NiuCard.NUMBER_10)
					{
						isSilver = false;
						isGold = false;
					}
				}

				if (isGold)
				{
					if (NiuCard.getNumber(c) < NiuCard.NUMBER_J)
					{					
						isGold = false;
					}	
				}

				if (isLittle)
				{
					sum += NiuCard.getValue(c);
					if (sum > 10)
					{
						isLittle = false;
					}
				}			
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