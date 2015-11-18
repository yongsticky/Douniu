package view.widget
{
	import camu.errors.AbstractClassError;
	
	import starling.core.Starling;
	import starling.display.Stage;
	import starling.events.Event;

	public class MessageBoxHelper
	{	
		static private var _msgBox:Widget_MessgeBox;
		static private var _func:Function;
			
		public function MessageBoxHelper()
		{
			throw new AbstractClassError();
		}
		
		
		public static function showMessageBox(infoText:String, buttonText:String, func:Function = null) : void
		{
		
			if (_msgBox == null)
			{
				_msgBox = new Widget_MessgeBox(null, infoText, buttonText);				
				_msgBox.addEventListener(Widget_MessgeBox.CLICK, onClick);
			}
			else
			{
				_msgBox.infoText = infoText;
				_msgBox.buttonText = buttonText;				
			}
			
			_func = func;
			
			var p:Stage = Starling.current.stage; 
			_msgBox.x = (p.width - _msgBox.width) / 2;
			_msgBox.y = (p.height - _msgBox.height) / 2;
			p.addChild(_msgBox);			
		}	
		
		private static function onClick(event:Event):void
		{
			if (_func)
			{
				_func();
			}
			else
			{
				_msgBox.hide();
			}
		}
	}
}