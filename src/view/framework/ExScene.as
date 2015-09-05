package view.framework
{		
	import starling.display.DisplayObject;
	
	import view.NiuDirector;


	public class ExScene extends ExSprite
	{		
		protected var _id:String;
		
		
		public function ExScene(id:String)
		{
			super();			
		}
		
		override protected function initialize() : void
		{
			super.initialize();			
		}
		
		public function onStageResize() : void
		{			
			layoutChildren();		
		}	

		public function get id() : String
		{
			return _id;
		}

		public function get isOnTop() : Boolean
		{			
			return (NiuDirector.instance().topScene.id == this.id);
		}
		
		public function addLayer(name:String, layer:ExLayer) : ExLayer
		{
			if (layer)
			{
				layer.name = name;
				addChild(layer);
			}

			return layer;
		}

		public function addLayerAt(name:String, layer:ExLayer, index:int) : ExLayer
		{
			if (layer)
			{
				layer.name = name;
				addChildAt(layer, index);
			}

			return layer;
		}

		public function getLayerAt(index:int) : ExLayer
		{
			var child:DisplayObject = getChildAt(index);
			return child as ExLayer;
		}

		public function getLayerByName(name:String) : ExLayer
		{
			var child:DisplayObject = getChildByName(name);
			return child as ExLayer;
		}

		public function getLayerIndex(layer:ExLayer) : int
		{
			return getChildIndex(layer);
		}

		public function removeLayer(layer:ExLayer, dispose:Boolean = false) : ExLayer
		{			
			var child:DisplayObject = removeChild(layer, dispose);
			return child as ExLayer;
		}

		public function removeLayerAt(index:int, dispose:Boolean = false) : ExLayer
		{
			var child:DisplayObject = removeChildAt(index, dispose);
			return child as ExLayer;
		}

		public function removeLayers(beg:int, end:int, dispose:Boolean = false) : void
		{
			removeChildren(beg, end, dispose);
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