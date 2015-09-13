package global
{	
	public class GlobalInfo
	{
		private var _uin:uint;
		private var _playerId:int;
		
		public function GlobalInfo(inner:PrivateInner)
		{
		}
		
		private static var _instance:GlobalInfo = null;
		public static function instance() : GlobalInfo
		{
			if (!_instance)
			{
				_instance = new GlobalInfo(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function set uin(uin:uint) : void
		{
			_uin = uin;
		}
		
		public function get uin() : uint
		{
			return _uin;
		}
		
		public function set playerId(id:int) : void
		{
			_playerId = id;
		}
		
		public function get playerId() : int
		{
			return _playerId;
		}
	}
}

class PrivateInner
{
	
}