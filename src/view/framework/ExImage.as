package view.framework
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.textures.Texture;
	

	public class ExImage extends Image
	{
		protected var texture:Texture;
		public function ExImage(res:*)
		{
			texture = null;			
			
			if (res is Bitmap)
			{
				texture = Texture.fromBitmap(res);
			}
			else if (res is BitmapData)
			{
				texture = Texture.fromBitmapData(res);
			}
			
			if (texture)
			{
				super(texture);
			}
			else
			{			
				throw new Error("Neither Bitmap nor BitmapData!");
			}
		}
		
		override public function dispose() : void
		{
			if (texture)
			{
				texture.dispose();
				texture = null;
			}		
			
			super.dispose();
		}
	}
}