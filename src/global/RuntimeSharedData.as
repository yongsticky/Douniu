package global
{	
	import global.structs.RSDRoomData;
	import global.structs.RSDTableData;
	import global.structs.RSDPlayerData;

	public class RuntimeSharedData
	{
		/*
		private var _uin:uint;
		private var _playerId:int;
		private var _roomId:int;
		private var _tableId:int;
		private var _seatId:int;
		private var _dealer:int;
		
		private var _nick:String;
		private var _chips:int;
		private var _gender:int;
		*/
		
		
		private var _rsdPlayerData:RSDPlayerData;
		private var _rsdTableData:RSDTableData;
		private var _rsdRoomData:RSDRoomData;

				
		public function RuntimeSharedData(inner:PrivateInner)
		{
			_rsdPlayerData = new RSDPlayerData();
			_rsdTableData = new RSDTableData();
			_rsdRoomData = new RSDRoomData();
		}
		
		private static var _instance:RuntimeSharedData = null;
		public static function instance() : RuntimeSharedData
		{
			if (!_instance)
			{
				_instance = new RuntimeSharedData(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function get rsdPlayerData() : RSDPlayerData
		{
			return _rsdPlayerData;
		}
		
		public function get rsdTableData() : RSDTableData
		{
			return _rsdTableData;
		}
		
		public function get rsdRoomData() : RSDRoomData
		{
			return _rsdRoomData;
		}
		
		/*
		public function set uin(value:uint) : void
		{
			_uin = value;
		}
		
		public function get uin() : uint
		{
			return _uin;
		}
		
		public function set playerId(value:int) : void
		{
			_playerId = value;
		}
		
		public function get playerId() : int
		{
			return _playerId;
		}
		
		public function set roomId(value:int) : void
		{
			_roomId = value;
		}
		
		public function get roomId() : int
		{
			return _roomId;
		}
		
		public function set tableId(value:int) : void
		{
			_tableId = value;
		}
		
		public function get tableId() : int
		{
			return _tableId;
		}
		
		public function set seatId(value:int) : void
		{
			_seatId = value;
		}
		
		public function get seatId() : int
		{
			return _seatId;
		}
		
		public function set dealer(value:int) : void
		{
			_dealer = value;
		}
		
		public function get dealer() : int
		{
			return _dealer;
		}
		
		public function set nick(value:String) : void
		{
			_nick = value;
		}
		
		public function get nick() : String
		{
			return _nick;
		}
		
		public function set chips(value:int) : void
		{
			_chips = value;
		}
		
		public function get chips() : int
		{
			return _chips;
		}
		
		public function set gender(value:int) : void
		{
			_gender = value;
		}
		
		public function get gender() : int
		{
			return _gender;
		}
		*/
	}
}

class PrivateInner
{
	
}