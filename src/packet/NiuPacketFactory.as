package packet
{
	import camu.object.BaseObjectFactory;
	import camu.object.IObjectCache;
	
	import packet.game.Request_Login;
	
	public class NiuPacketFactory extends BaseObjectFactory
	{
		public function NiuPacketFactory(objCache:IObjectCache = null)
		{
			super(objCache);			
			
			registerClass(Request_Login);
		}
	}
}