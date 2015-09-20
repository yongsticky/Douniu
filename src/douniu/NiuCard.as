package douniu
{
	import camu.errors.AbstractClassError;

	public class NiuCard
	{
		/*
	
			0 ~ 51  黑红梅方 A到K
		
		1~13  hei  A ~ K
		14~26 hong A ~ K
		27~39 mei A ~ K
		40~52 fang A ~ K

		*/

		public static const COLOR_BLACK:int = 0;
		public static const COLOR_RED:int = 1;
		public static const COLOR_PLUM:int = 2;
		public static const COLOR_SQUARE:int = 3;

		public static const NUMBER_A:int = 1;
		public static const NUMBER_2:int = 2;
		public static const NUMBER_3:int = 3;
		public static const NUMBER_4:int = 4;
		public static const NUMBER_5:int = 5;
		public static const NUMBER_6:int = 6;
		public static const NUMBER_7:int = 7;
		public static const NUMBER_8:int = 8;
		public static const NUMBER_9:int = 9;
		public static const NUMBER_10:int = 10;
		public static const NUMBER_J:int = 11;
		public static const NUMBER_Q:int = 12;
		public static const NUMBER_K:int = 13;

		private var _data:int = 0;

		public function NiuCard()
		{
			throw new AbstractClassError();
		}
		
		// 获取花色
		public static function getColor(data:int) : int
		{
			if (data == 52)
			{
				return 0;
			}
			else
			{
				return data/13;
			}
		}
		
		// 获取数字
		public static function getNumber(data:int) :int
		{
			var n:int = data%13;
			return n>0 ? n:13;
		}
		
		// 获取计算值
		public static function getValue(data:int) : int
		{
			var v:int = getNumber(data);
			return v<10? v:10; 
		}		
	}
}