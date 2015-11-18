package global.structs
{
	public class REDPlayerData
	{
		public var uin:uint = 10000000;
		public var player_id:int;
		public var seat_id:int;
		
		public var locked_room:int = 0;
		
		public var nick:String = "调试账号";
		public var gender:int;
		
		public var money:int = 0;
		public var note:int = 0;
				
		public var sid:String = "00000000000000000000000000000000";
		
		public function REDPlayerData()
		{
		}
	}
}