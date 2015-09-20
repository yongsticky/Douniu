package view.framework
{
		
	
	
	import camu.errors.AbstractFunctionError;
	import camu.errors.NullObjectError;
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;

	public class ExSprite extends Sprite
	{
		protected var _logger:ILogger;
		
		protected var _width:Number;
		protected var _height:Number;
		
		public function ExSprite(name:String = null)
		{
			super();
			
			_logger = Logger.createLogger(ExSprite, LEVEL.WARNING);
			
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
			throw new AbstractFunctionError();			
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
		
		/*
		override public function set width(value:Number) : void
		{
			_width = value;
			
			if (numChildren > 0)
			{
				super.width = value;				
			}			
		}
		
		override public function get width():Number
		{
			if (numChildren > 0)
			{
				return super.width;
			}
			else
			{
				return _width;
			}
		}
		
		override public function set height(value:Number) : void
		{
			_height = value;
			
			if (numChildren > 0)
			{
				super.height = value;
			}			
		}	
		
		override public function get height():Number
		{
			if (numChildren > 0)
			{
				return super.height;
			}
			else
			{
				return _height;
			}
		}*/
	
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
					p = p.parent;
				}			
			}
			
			throw new NullObjectError();			
		}
		
		/** Returns a namede-child object with a certain name (support recursively). */
		public function getChildByNameWithRecursive(name:String) : *
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
					obj = child.getChildByNameWithRecursive(name);
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