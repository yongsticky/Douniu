package view.framework
{
		
	
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;

	public class ExSprite extends Sprite
	{
		public function ExSprite(name:String = null)
		{
			super();
			
			if (name)
			{
				this.name = name;
			}
			
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
			throw new Error("Abstract function, you must override it.");	
		}

		protected function layoutChildren() : void
		{
			var maxCount:int = numChildren;
			for (var i:int; i < maxCount; i++)
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
		
		/** Returns a namede-child object with a certain name (support recursively). */
		public function getNamedChildByName(name:String) : *
		{
			var obj:* = null;
			obj = getChildByName(name);
			if (obj)
			{
				return obj;
			}
			
			var maxCount:int = numChildren;
			for (var i:int = 0; i < maxCount; i++)
			{
				var child:ExSprite = getChildAt(i) as ExSprite;
				if (child)
				{
					obj = child.getNamedChildByName(name);
					if (obj)
					{
						return obj;
					}
				}
			}
			
			return null;
		}
	}
}