package view.scene.loading.cell
{
	import flash.geom.Rectangle;
	
	import starling.text.TextField;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Progress extends ExSprite
	{
		[Embed(source="../../../../../resource/progress_bg.png")]
		private static const ProgressBg:Class;
		
		[Embed(source="../../../../../resource/progress_inner.png")]
		private static const ProgressInner:Class;
		
		[Embed(source="../../../../../resource/progress_outer_l.png")]
		private static const ProgressOuterLeft:Class;
		
		[Embed(source="../../../../../resource/progress_outer_r.png")]
		private static const ProgressOuterRight:Class;
		
		
		private var _percent:TextField;
		private var _bg:ExImage;
		private var _inner:ExImage;
		private var _outerLeft:ExImage;
		private var _outerRight:ExImage;
		
		private var _innerClipRect:Rectangle;
		private var _outerClipRect:Rectangle;
		
		public function Progress(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren():void
		{
			_percent = new TextField(100, 24, "", "Microsoft YaHei", 12, 0xFDBC2A);			
			_percent.x = 150;
			addChild(_percent);
			
			_bg = new ExImage(new ProgressBg());
			_bg.y = 32;
			addChild(_bg);			
			
			_outerClipRect = new Rectangle(0, 0, 0, 16);
			_outerLeft = new ExImage(new ProgressOuterLeft());
			_outerLeft.y = 32;
			_outerLeft.width = 0;
			_outerLeft.clipRect = _outerClipRect;
			addChild(_outerLeft);
			
			_innerClipRect = new Rectangle(0, 0, 0, 16);
			_inner = new ExImage(new ProgressInner());
			_inner.x = 4;
			_inner.y = 32;			
			_inner.clipRect = _innerClipRect;
			addChild(_inner);
			
			_outerRight = new ExImage(new ProgressOuterRight());
			_outerRight.y = 32;
			_outerRight.visible = false;
			addChild(_outerRight);			
		}
		
		public function updatePercent(percent:int) : void
		{
			_percent.text = percent.toString() + "%";
						
			_outerLeft.clipRect.width = 400*percent/100 - 8;
			_inner.clipRect.width = 400*percent/100 - 8;
			
			if (percent > 0)
			{
				_outerRight.x = _outerLeft.x + _outerLeft.clipRect.width;
				_outerRight.visible = true;
			}
		}
	}
}