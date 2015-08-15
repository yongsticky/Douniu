package douniu
{
	public class NiuCard
	{
		/*
	
			0 ~ 51  黑红梅方 A到K

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

		public function NiuCard(data:int)
		{
			_data = data;
		}

		public function reset(data:int) : void
		{
			_data = data;
		}

		public function get color() : int
		{
			var c:int = _data % 4;
			return c;
		}

		public function get number() : int
		{
			var n:int = (_data >> 2) + 1;
			return n;
		}

		public function get value() : int
		{
			var v:int = this.number;
			return (v<10 ? v:10);
		}
	}
}