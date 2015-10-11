package global
{	
	import global.structs.REDRoomData;
	import global.structs.REDTableData;
	import global.structs.REDPlayerData;

	public class RuntimeExchangeData
	{		
		private var _redPlayerData:REDPlayerData;
		private var _redTableData:REDTableData;
		private var _redRoomData:REDRoomData;
				
		public function RuntimeExchangeData(inner:PrivateInner)
		{
			_redPlayerData = new REDPlayerData();
			_redTableData = new REDTableData();
			_redRoomData = new REDRoomData();
		}
		
		private static var _instance:RuntimeExchangeData = null;
		public static function instance() : RuntimeExchangeData
		{
			if (!_instance)
			{
				_instance = new RuntimeExchangeData(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function get redPlayerData() : REDPlayerData
		{
			return _redPlayerData;
		}
		
		public function get redTableData() : REDTableData
		{
			return _redTableData;
		}
		
		public function get redRoomData() : REDRoomData
		{
			return _redRoomData;
		}		
	}
}

class PrivateInner
{
	
}