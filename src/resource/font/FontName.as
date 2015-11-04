package resource.font
{
	import camu.errors.AbstractClassError;

	public class FontName
	{
		public static const YAHEI:String = "Microsoft YaHei";
		public static const ARIAL:String = "Arial";
		
		public function FontName()
		{
			throw new AbstractClassError();
		}
	}
}