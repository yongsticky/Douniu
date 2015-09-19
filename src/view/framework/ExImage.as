package view.framework
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import camu.errors.UnhandledBranchError;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import camu.errors.ZeroError;
	
	public class ExImage extends Sprite
	{
		protected var _texture:Texture;
		protected var _starlingImage:Image;
		
		
		public function ExImage(res:* = null)
		{			
			this.res = res;		
			
			super();
		}
		
		public function set res(res:*) : void
		{	
			if (res == null)
			{
				destoryStarlingImage();
				_texture = null;
			}
			else
			{			
				if (res is Bitmap)
				{
					_texture = Texture.fromBitmap(res);
				}
				else if (res is BitmapData)
				{
					_texture = Texture.fromBitmapData(res);
				}
				else if (res is Texture)
				{
					_texture = res;
				}
				else
				{
					throw new UnhandledBranchError();					
				}
				
				updateStarlingImage();
			}
		}
	
		protected function updateStarlingImage() : void
		{			
			if (_texture)
			{
				if (!_starlingImage)
				{
					_starlingImage = new Image(_texture);
					addChild(_starlingImage);
				}
				else
				{
					_starlingImage.texture = _texture;
				}				
			}
		}
		
		protected function destoryStarlingImage() : void
		{
			if (_starlingImage)
			{
				removeChild(_starlingImage, true);				
				_starlingImage = null;
			}
		}
		
		override public function set width(value:Number) : void
		{
			if (numChildren == 0)
			{
				throw new ZeroError();
			}
			
			super.width = value;
		}
		
		override public function set height(value:Number) : void
		{
			if (numChildren == 0)
			{
				throw new ZeroError();
			}
			
			super.height = value;
		}	
	}
}