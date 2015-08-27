package packet
{
	import camu.net.Packet;
	import camu.object.BaseObjectFactory;
	import camu.object.IObjectCache;
	
	import packet.game.Login.Request_Login;
	
	public class NiuPacketFactory extends BaseObjectFactory
	{
		public function NiuPacketFactory(objCache:IObjectCache = null)
		{
			super(objCache);			
			
			registerClass(Request_Login);
		}
		
		public function createPacketInstance(msgId:int) : Packet
		{
			var cls:Class = getPacketClass(msgId);
			return super.createInstance(cls) as Packet;
		}
		
		protected function getPacketClass(msgId:int) : Class
		{
			return Request_Login;
		}
	}
}