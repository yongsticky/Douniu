package global
{
	public class ProgramConfiguration
	{
		private var _serverHost:String;
		private var _serverPort:int;
		
		public function ProgramConfiguration(inner:PrivateInner)
		{		
		}
		
		private static var _instance:ProgramConfiguration = null;
		public static function instance() : ProgramConfiguration
		{
			if (!_instance)
			{
				_instance = new ProgramConfiguration(new PrivateInner());
				_instance.initialize();
			}
			
			return _instance;
		}
		
		private function initialize() : void
		{
			_serverHost = "114.119.36.221";
			//_serverHost = "app.camu.com";
			_serverPort = 8000;
		}
	
		public function get serverHost() : String
		{
			return _serverHost;
		}
		
		public function get serverPort() : int
		{
			return _serverPort;
		}		
	}
}

class PrivateInner
{
	
}