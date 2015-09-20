package view.framework
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import camu.errors.UnhandledBranchError;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class ExImage extends ExSprite
	{
		protected var _texture:Texture;
		protected var _starlingImage:Image;
		//protected var _initRes:*;
		
		
		public function ExImage(res:* = null)
		{	
			super();
			
			//_initRes = res;
			this.res = res;
		}
		
		override protected function createChildren():void
		{
			//this.res = _initRes;
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
					
					
					_starlingImage.width = _texture.width;
					_starlingImage.height = _texture.height;
					
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
	}
}