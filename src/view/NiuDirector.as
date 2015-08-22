package view
{
	import flash.utils.getQualifiedClassName;
	
	import camu.util.log.ILogger;
	import camu.util.log.LogLevel;
	import camu.util.log.Logger;
	import camu.view.starling.ExDirector;
	
	
	public class NiuDirector extends ExDirector
	{
		private var _logger:ILogger = null;
		
		public function NiuDirector()
		{
			super();
			
			_logger = Logger.createLogger(getQualifiedClassName(this), LogLevel.DEBUG);		
			
		}
		
		override protected function initialize():void
		{
			super.initialize();	
			
			_logger.log("initialize called.", LogLevel.INFO);
		}
	}
}