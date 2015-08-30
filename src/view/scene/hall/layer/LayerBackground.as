package view.scene.hall.layer
{	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	import view.framework.ExLayer;

	public class LayerBackground extends ExLayer
	{
		[Embed(source="../../../../../resource/hall/hallres.swf#bg.png")]
		private static const HallBackgourndPNG:Class;
		
				
		private var _bkgImg:Image;
		
		public function LayerBackground()
		{
			super();
		}
		
		override protected function initialize() : void
		{
			super.initialize();
			
			createAllChildren();			
		}
		
		
		private function createAllChildren() : void
		{
			var png:* = new HallBackgourndPNG();
			
			var t:Texture;
			if (png is Bitmap)
			{
				t = Texture.fromBitmap(png);	
			}
			else if (png is BitmapData)
			{
				t = Texture.fromBitmapData(png);
			}
			else
			{
				
			}
			
			_bkgImg = new Image(t);
			_bkgImg.x = _bkgImg.y = 0;
			
			addChild(_bkgImg);
		}
	}
}