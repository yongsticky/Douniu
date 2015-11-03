package view.scene.loading
{		
	
	import flash.display3D.Context3DTextureFormat;
	import flash.geom.Point;
	
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import view.framework.ExImage;
	import view.framework.ExScene;
	import view.scene.loading.layer.Layer_Loading;
	
	
	
	public class Scene_Loading extends ExScene
	{		
		[Embed(source="../../../../resource/loading_bg.jpg")]
		private static const LoadingBG:Class;
		
		[Embed(source="../../../../resource/logo.png")]
		private static const Logo:Class;
		
		private var _bg:ExImage;
		private var _logo:ExImage;
		
		public function Scene_Loading(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{		
			_bg = new ExImage(Texture.fromBitmap(new LoadingBG(), true, false, 1, Context3DTextureFormat.BGRA, true));		
			
			addChild(_bg);	
			
			
			_logo = new ExImage(new Logo());
			addChild(_logo);
			
			addChild(new Layer_Loading("loading"));
		}
		
		override protected function layoutChildren():void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;			
			
			
			_bg.image.setTexCoords(1, new Point(_bg.width/_bg.texture.width, 0));
			_bg.image.setTexCoords(2, new Point(0, _bg.height/_bg.texture.height));
			_bg.image.setTexCoords(3, new Point(_bg.width/_bg.texture.width, _bg.height/_bg.texture.height));
			
			
			_logo.x = (stage.stageWidth - _logo.width) / 2;
			_logo.y = (stage.stageHeight - _logo.height) / 2 - 100;
			
			super.layoutChildren();
		}
	}
}