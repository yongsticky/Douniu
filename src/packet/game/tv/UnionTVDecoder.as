package packet.game.tv
{
	import flash.utils.ByteArray;
	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	
	import factory.NiuObjectFactory;
	

	public class UnionTVDecoder
	{
		private var _logger:ILogger;
		
		public function UnionTVDecoder(inner:PrivateInner)
		{
			_logger = Logger.createLogger(UnionTVDecoder, LEVEL.INFO);
		}
		
		private static var _instance:UnionTVDecoder = null;
		public static function instance() : UnionTVDecoder
		{
			if (!_instance)
			{
				_instance = new UnionTVDecoder(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function decode(bytes:ByteArray) : UnionTV
		{
			var _factory:NiuObjectFactory = NiuObjectFactory.instance();
			
			var tvType:int = peekTVType(bytes);
			var tvValue:TVValue = _factory.createInstance(TVType.TVTypeToClass(tvType));			
			if (tvValue)
			{
				var uTV:UnionTV = _factory.createInstance(UnionTV);
				if (uTV)
				{
					uTV.value = tvValue;				
					uTV.unpack(bytes);	
				}										
				else
				{
					throw new Error("Not UnionTV Class.");
				}
				
				return uTV;
			}
			else
			{
				throw new Error("TV [type=" + tvType + "] NOT EXIST!");	
			}			
		}
		
		protected function peekTVType(bytes:ByteArray) : int
		{
			var tvType:int = bytes.readInt();
			bytes.position -= 4;
			
			_logger.log("peekTVType, TV Type = ", tvType, LEVEL.INFO);
			
			return tvType;
		}
	}
}

class PrivateInner
{
	
}