package view.scene.hall.layer
{	
	
	import view.framework.ExImage;
	import view.framework.ExLayer;

	public class LayerBackground extends ExLayer
	{
		[Embed(source="../../../../../resource/hall/hallres.swf#bg.png")]
		private static const HallBackgourndPNG:Class;
		
				
		private var _bkgImage:ExImage;
		
		public function LayerBackground()
		{
			super();
		}		
		
		override protected function createChildren() : void
		{
			_bkgImage = new ExImage(new HallBackgourndPNG());
		
			addChild(_bkgImage);
		}
	}
}