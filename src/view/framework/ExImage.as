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
		protected var _imager:Image;	
		
		protected var _width:Number;
		protected var _height:Number;
		
		
		public function ExImage(res:* = null)
		{	
			super();			
			
			this.res = res;
		}
		
		override protected function createChildren():void
		{			
		}
		
		override public function set width(value:Number) : void
		{
			_width = value;
			updateTexture();
		}
		
		override public function set height(value:Number) : void
		{
			_height = value;
			updateTexture();
		}
				  
		
		public function set res(res:*) : void
		{	
			if (res == null)
			{
				destoryTexture();
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
				
				_width = _texture.width;
				_height = _texture.height;
				
				updateTexture();
			}
		}		
	
		protected function updateTexture() : void
		{			
			if (_texture)
			{				
				if (!_imager)
				{
					_imager = new Image(_texture);
					addChild(_imager);
				}
				else
				{	
					_imager.texture = _texture;								
				}
				
				_imager.width = _width;
				_imager.height = _height;
			}
		}
		
		protected function destoryTexture() : void
		{
			if (_imager)
			{
				removeChild(_imager, true);				
				_imager = null;
			}
		}		
	}
}