package view.framework
{	
	import view.NiuDirector;

	public class ExScene extends ExSprite
	{		
		public function ExScene(name:String = null)
		{
			super(name);
		}
		
		override protected function initialize() : void
		{
			super.initialize();	
		}

		public function get isOnTop() : Boolean
		{			
			return (NiuDirector.instance().topScene.name == this.name);
		}	

		public function pauseAnimation() : void
		{
			var maxCount:int = numChildren;
			for (var i:int = 0; i < maxCount; i++)
			{
				var layer:ExLayer = getChildAt(i) as ExLayer;
				if (layer)
				{
					layer.pauseAnimation();
				}
			}
		}

		public function resumeAnimation() : void
		{
			var maxCount:int = numChildren;
			for (var i:int = 0; i < maxCount; i++)
			{
				var layer:ExLayer = getChildAt(i) as ExLayer;
				if (layer)
				{
					layer.resumeAnimation();
				}
			}
		}
	}
}