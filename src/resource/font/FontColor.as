package resource.font
{
	import camu.errors.AbstractClassError;

	public class FontColor
	{
		public static const WHITE:uint = 0xFFFFFF;
		public static const DARKRED:uint = 0x671515;
		
		public function FontColor()
		{
			throw new AbstractClassError();
		}
	}
}