package view.framework
{
		
	
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;

	public class ExSprite extends Sprite
	{
		public function ExSprite()
		{
			super();
			
			stage ? initialize():addEventListener(Event.ADDED_TO_STAGE, function (event:Event) : void {
				event.target.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				initialize();
			});
		}

		protected function initialize() : void
		{
			createChildren();			
			layoutChildren();
		}				
		
		protected function createChildren() : void
		{
			throw new Error("Abstract Function.");	
		}

		protected function layoutChildren() : void
		{
			for (var i:int; i < numChildren; i++)
			{				
				var child:DisplayObject = getChildAt(i);
				if (child is ExSprite)
				{
					ExSprite(child).layoutChildren();
				}
			}
		}
		
		public function getOwnerLayer() : ExLayer
		{
			var p:DisplayObjectContainer = parent;
			while(p)
			{
				if (p is ExLayer)
				{
					return (p as ExLayer);
				}
				else
				{
					p = parent;
				}			
			}
			
			throw new Error("Class NOT Layer's child.");
		}
	}
}