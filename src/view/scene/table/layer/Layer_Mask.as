package view.scene.table.layer
{	
		
	
	
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.GradientGlowFilter;
	
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import view.framework.ExImage;
	import view.framework.ExLayer;
	
	
	public class Layer_Mask extends ExLayer
	{
		private var _bg:ExImage;
		
		private var _num:TextField;
		
		private var _num2:TextField;
		
		public function Layer_Mask(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			_bg = new ExImage(Texture.fromColor(1, 1, 0xAA000000));
			addChild(_bg);
			
			
			
			
			_num = new TextField(100, 40, "+162", "Arial", 24, 0xcd0000);			
			_num.x = 200;
			_num.y = 200;
			_num.bold = true;
			addChild(_num);
			
			
			_num2 = new TextField(100, 40, "-600", "Arial", 24, 0xe96f0f);			
			_num2.x = 400;
			_num2.y = 200;
			_num2.bold = true;
			addChild(_num2);
		
		}
		
		override protected function layoutChildren():void
		{
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
			
			super.layoutChildren();
		}
		
		public function showMask() : void
		{
			visible = true;
		}	
	}
}