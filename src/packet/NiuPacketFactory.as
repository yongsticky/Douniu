package packet
{
	import camu.net.Packet;	
	import camu.object.BaseObjectFactory;
	import camu.object.IObjectCache;
	import camu.net.PacketEventCreator;
	import camu.net.PacketEvent;
	
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Login.Request_Login;
	import packet.game.message.WrapperMessage.Response_WrapperMessage;	
	
	
	public class NiuPacketFactory extends BaseObjectFactory
	{
		public function NiuPacketFactory(objCache:IObjectCache = null)
		{
			super(objCache);		
			
			registerClass(PacketEvent, new PacketEventCreator());
			
			registerClass(Request_Login);
			registerClass(Response_Login);
			registerClass(Response_WrapperMessage);
		}
		
		public function createPacketInstance(msgId:int) : Packet
		{
			var cls:Class = getPacketClass(msgId);
			if (cls)
			{
				return createInstance(cls) as Packet;
			}
			else
			{
				return null;
			}
		}
		
		protected function getPacketClass(msgId:int) : Class
		{
			switch(msgId)
			{
				case 15814:
					return Response_WrapperMessage;
				case 15801:
					return Response_Login;
				default:
					return null;
			}
		}
	}
}