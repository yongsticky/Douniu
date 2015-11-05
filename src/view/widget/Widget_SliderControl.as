package view.widget
{
	import flash.geom.Point;
	
	import resource.ResManager;
	import resource.font.FontColor;
	import resource.font.FontName;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_SliderControl extends ExSprite
	{	
		public static const STATUS:String = "widget.slider_control.status";
		
		private var _tracker:ExImage;
		private var _slider:Widget_ImageTextField;
		
		private var _value:int;
		private var _enabled:Boolean;
		
		
		private var _movePoint:Point;
		
		public function Widget_SliderControl(name:String=null, val:int = 0, enabled:Boolean = true)
		{
			super(name);
			
			_movePoint = new Point();
			
			_value = val;
			
			_enabled = enabled;
		}
		
		override protected function createChildren():void
		{
			var resManager:ResManager = ResManager.instance();			
			
			_tracker = new ExImage(resManager.getResource("ui.slider_tracker"));			
			addChild(_tracker);
			
			_slider = new Widget_ImageTextField();
			_slider.pivotX = 13;
			_slider.pivotY = 13;
			_slider.y = 6;
			_slider.setTextAnchor(1, 3);		
			addChild(_slider);			
			
			_slider.setBackground(resManager.getResource("ui.slider"));
			_slider.textField.fontName = FontName.ARIAL;
			_slider.textField.fontSize = 14;
			_slider.textField.color = FontColor.BEIGE;			
			_slider.setText(_value.toString());			
						
			updateSliderPosition();
			
			if (_enabled)
			{
				_tracker.addEventListener(TouchEvent.TOUCH, onTouchTracker);
				_slider.addEventListener(TouchEvent.TOUCH, onTouchSlider);
			}
			else
			{
				alpha = 0.3;
			}
		}
		
		private function onTouchTracker(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_tracker, TouchPhase.ENDED);
			if (touch)
			{
				var pt:Point = touch.getLocation(_tracker);					
				value = Math.floor(pt.x / 30);
				
				event.stopImmediatePropagation();
			}			
		}
		
		private function onTouchSlider(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_slider, TouchPhase.MOVED);
			if (touch)
			{
				touch.getLocation(_tracker, _movePoint);
				if (_movePoint.y > -10 && _movePoint.y < 46 && _movePoint.x > 0 && _movePoint.x < 284)
				{
					value = Math.floor(_movePoint.x / 30);
				}		
				
				event.stopImmediatePropagation();
			}					
		}				
		
		public function get value() : int
		{
			return _value;
		}
		
		public function set value(val:int) : void
		{
			if (_value != val)
			{
				_value = val;
				
				updateSliderPosition();
				
				dispatchEvent(new Event(STATUS, false, _value));
			}			
		}
		
		public function set enabled(value:Boolean) : void
		{
			if (_enabled != value)
			{
				_enabled = value;
				
				if (_enabled)
				{
					alpha = 1.0;
					_tracker.addEventListener(TouchEvent.TOUCH, onTouchTracker);
					_slider.addEventListener(TouchEvent.TOUCH, onTouchSlider);
				}
				else
				{
					alpha = 0.3;
					_tracker.removeEventListener(TouchEvent.TOUCH, onTouchTracker);
					_slider.removeEventListener(TouchEvent.TOUCH, onTouchSlider);
				}
			}			
		}
		
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		
		private function updateSliderPosition() : void
		{
			_slider.x = _value*30 + 1;
			
			_slider.setText(_value.toString());
		}
	}
}