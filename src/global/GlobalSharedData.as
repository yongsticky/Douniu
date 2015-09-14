package global
{	
	public class GlobalSharedData
	{
		private var _uin:uint;
		private var _playerId:int;
		private var _roomId:int;
		private var _tableId:int;
		private var _seatId:int;
		private var _dealer:int;
		
		public function GlobalSharedData(inner:PrivateInner)
		{
		}
		
		private static var _instance:GlobalSharedData = null;
		public static function instance() : GlobalSharedData
		{
			if (!_instance)
			{
				_instance = new GlobalSharedData(new PrivateInner());
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
		
		public function set roomId(id:int) : void
		{
			_roomId = id;
		}
		
		public function get roomId() : int
		{
			return _roomId;
		}
		
		public function set tableId(id:int) : void
		{
			_tableId = id;
		}
		
		public function get tableId() : int
		{
			return _tableId;
		}
		
		public function set seatId(id:int) : void
		{
			_seatId = id;
		}
		
		public function get seatId() : int
		{
			return _seatId;
		}
		
		public function set dealer(dealer:int) : void
		{
			_dealer = dealer;
		}
		
		public function get dealer() : int
		{
			return _dealer;
		}
	}
}

class PrivateInner
{
	
}