package factory
{
	import camu.design_pattern.Singleton;
	import camu.net.Packet;
	import camu.net.PacketEvent;
	import camu.net.PacketEventCreator;
	import camu.object.DefaultObjectFactory;
	import camu.object.IObjectContainer;
	
	import packet.game.message.Login.Request_Login;
	import packet.game.message.Login.Response_Login;
	import packet.game.message.WrapperMessage.Response_WrapperMessage;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVCreator;
	import packet.game.tlv.value.BaseGameCfgData;
	import packet.game.tlv.value.ExitPlayerInfo;
	import packet.game.tlv.value.GameMsgInfo;
	import packet.game.tlv.value.GameScoreValue;
	import packet.game.tlv.value.LockInfo;
	import packet.game.tlv.value.PlayerCapability;
	import packet.game.tlv.value.PlayerDetailInfo;
	import packet.game.tlv.value.PlayerMoneyChangeInfo;
	import packet.game.tlv.value.PlayerViewSeatInfo;
	import packet.game.tlv.value.T3DMJPlayInfo;
	import packet.game.tlv.value.TClientInfo;
	import packet.game.tlv.value.TDNPlayInfo;
	import packet.game.tlv.value.TableSimpleInfo;
	
	
	public class NiuObjectFactory extends DefaultObjectFactory
	{
		public function NiuObjectFactory(objCache:IObjectContainer = null)
		{
			super(objCache);
			
			registerClass(PacketEvent, {"objectCreator":new PacketEventCreator()});
			
			registerClass(Request_Login);
			registerClass(Response_Login);
			registerClass(Response_WrapperMessage);			
			
			registerClass(BaseGameCfgData);
			registerClass(ExitPlayerInfo);
			registerClass(GameMsgInfo);
			registerClass(GameScoreValue);
			registerClass(LockInfo);
			registerClass(PlayerCapability);
			registerClass(PlayerDetailInfo);
			registerClass(PlayerMoneyChangeInfo);
			registerClass(PlayerViewSeatInfo);
			registerClass(T3DMJPlayInfo);
			registerClass(TableSimpleInfo);
			registerClass(TClientInfo);
			registerClass(TDNPlayInfo);
			
			registerClass(UnionTLV, {"objectCreator":new UnionTLVCreator()});
		}
		
		public static function instance() : NiuObjectFactory
		{
			return Singleton.instanceOf(NiuObjectFactory);
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

		public function createUnionTLVInstance(typeTLV:int) : UnionTLV
		{
			var newUTLV:UnionTLV;
			var valueCls:Class = getTLVValueClass(typeTLV);
			if (valueCls)
			{
				return createInstance(UnionTLV, valueCls) as UnionTLV;			
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

		protected function getTLVValueClass(typeTLV:int) : Class
		{
			switch(typeTLV)
			{
				case TLVType.UP_TLV_CLIENT_INFO:
					return TClientInfo;
				case TLVType.DN_TLV_PLAYERDETAIL:
					return PlayerDetailInfo;
				case TLVType.DN_TLV_VIEW_SEAT_INFO:
					return PlayerViewSeatInfo;
				case TLVType.DN_TLV_TABLE_SIMPLE_INFO:
					return TableSimpleInfo;
				case TLVType.DN_TLV_MONEY_CHANGE_INFO:
					return PlayerMoneyChangeInfo;
				case TLVType.DN_TLV_GAME_MSG_INFO:
					return GameMsgInfo;
				case TLVType.DN_TLV_LOCK_INFO:
					return LockInfo;
				case TLVType.DN_TLV_BASE_GAME_CFG:
					return BaseGameCfgData;
				case TLVType.DN_TLV_PLAYER_CAPABILITY:
					return PlayerCapability;
				case TLVType.DN_TLV_EXIT_PLAYER_INFO:
					return ExitPlayerInfo;
				case TLVType.DN_TLV_GAME_SCORE_MSG:
					return GameScoreValue;
				default:
					throw new Error("no match TLVType.");
			}
		}
	}
}