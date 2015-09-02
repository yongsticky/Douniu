package factory
{
	import camu.net.Packet;
	import camu.object.DefaultObjectFactory;
	import camu.object.IObjectContainer;
	import camu.singleton.Singleton;
	
	import packet.game.message.MSGID;
	import packet.game.message.Login.Request_Login;
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Logout.Request_Logout;
	import packet.game.message.Logout.Response_Logout;
	import packet.game.message.Notify.Response_GameNotify;
	import packet.game.message.Notify.TGameEvent;
	import packet.game.message.Ready.Request_Ready;
	import packet.game.message.Ready.Response_Ready;
	import packet.game.message.Sitdown.Request_Sitdown;
	import packet.game.message.Sitdown.Response_Sitdown;
	import packet.game.message.Standup.Request_Standup;
	import packet.game.message.Standup.Response_Standup;
	import packet.game.message.WrapperMessage.Response_WrapperMessage;
	import packet.game.tlv.TLVType;
	import packet.game.tlv.UnionTLV;
	import packet.game.tlv.UnionTLVCreator;	
	import packet.game.tlv.value.ExitPlayerInfo;
	import packet.game.tlv.value.GameMsgInfo;
	import packet.game.tlv.value.GameScoreValue;
	import packet.game.tlv.value.LockInfo;
	import packet.game.tlv.value.PlayerCapability;
	import packet.game.tlv.value.PlayerDetailInfo;
	import packet.game.tlv.value.PlayerMoneyChangeInfo;
	import packet.game.tlv.value.PlayerViewSeatInfo;
	import packet.game.tlv.value.BaseGameCfgData;
	import packet.game.tlv.value.TPlayerAvatarChangeInfo;
	import packet.game.tlv.value.T3DMJPlayInfo;
	import packet.game.tlv.value.TAppointmentKey;
	import packet.game.tlv.value.TClientInfo;
	import packet.game.tlv.value.TCompeteBuffer;
	import packet.game.tlv.value.TDNPlayInfo;
	import packet.game.tlv.value.TMatchTickKey;
	import packet.game.tlv.value.TPlayerCountNormalItemChangeInfo;
	import packet.game.tlv.value.TPlayerKickOutInfo;
	import packet.game.tlv.value.TableSimpleInfo;
	import packet.protocol.NiuPacket;
		
		
	public class NiuObjectFactory extends DefaultObjectFactory
	{		
		public function NiuObjectFactory(objCache:IObjectContainer = null)
		{
			super(objCache);	
				
			
			registerClass(Request_Login);
			registerClass(Response_Login);
			registerClass(Response_WrapperMessage);	
			registerClass(Request_Sitdown);
			registerClass(Response_Sitdown);
			registerClass(Request_Logout);
			registerClass(Response_Logout);
			registerClass(Request_Ready);
			registerClass(Response_Ready);
			registerClass(Request_Standup);
			registerClass(Response_Standup);
			registerClass(Response_GameNotify);
			
			registerClass(TAppointmentKey);
			registerClass(TCompeteBuffer);
			registerClass(TClientInfo);
			registerClass(PlayerDetailInfo);			
			registerClass(PlayerViewSeatInfo);
			registerClass(TPlayerKickOutInfo);			
			registerClass(TableSimpleInfo);
			registerClass(PlayerMoneyChangeInfo);	
			registerClass(TPlayerCountNormalItemChangeInfo);
			registerClass(BaseGameCfgData);
			registerClass(TPlayerAvatarChangeInfo);
			registerClass(ExitPlayerInfo);			
			registerClass(TMatchTickKey);
			registerClass(GameMsgInfo);
			registerClass(GameScoreValue);
			registerClass(LockInfo);
			registerClass(PlayerCapability);			
			registerClass(T3DMJPlayInfo);			
			registerClass(TDNPlayInfo);				
			registerClass(UnionTLV, {"objectCreator":new UnionTLVCreator()});
			registerClass(TGameEvent);
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
		
		override public function destroyInstance(obj:*) : void
		{			
			if (obj is NiuPacket)
			{
				(obj as NiuPacket).dispose();
			}
			
			super.destroyInstance(obj);
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
				case MSGID.RESPONSE_WRAPPER_MESSAGE:
					return Response_WrapperMessage;
				case MSGID.RESPONSE_LOGIN:
					return Response_Login;
				case MSGID.RESPONSE_LOGOUT:
					return Response_Logout; 
				case MSGID.RESPONSE_SITDOWN:
					return Response_Sitdown;
				case MSGID.RESPONSE_STANDUP:
					return Response_Standup;
				case MSGID.RESPONSE_READY:
					return Response_Ready;	
				case MSGID.RESPONSE_GAMEEVENT:
					return Response_GameNotify;
				default:
					throw new Error("msgId ["+ msgId+"] NOT Match any Response.");					
			}
		}

		protected function getTLVValueClass(typeTLV:int) : Class
		{
			switch(typeTLV)
			{
				case TLVType.UP_TLV_APPOINTMENT_KEY:			// 1
					return TAppointmentKey;
				case TLVType.UP_TLV_TGA_COMETE_BUFFER:			// 2
					return TCompeteBuffer;				
				case TLVType.UP_TLV_CLIENT_INFO:				// 3
					return TClientInfo;
				case TLVType.UP_TLV_MATCH_TICK_KEY:				// 4
					return TMatchTickKey;
				//case TLVType.DN_TLV_SVRINFO:					// 10000
				//	return null;
				case TLVType.DN_TLV_PLAYERDETAIL:				// 10001
					return PlayerDetailInfo;
				//case TLVType.DN_TLV_ITEMINFO:					// 10002
				//	return null;
				case TLVType.DN_TLV_VIEW_SEAT_INFO:				// 10003
					return PlayerViewSeatInfo;
				case TLVType.DN_TLV_KICKOUT_INFO:				// 10004
					return TPlayerKickOutInfo;
				case TLVType.DN_TLV_TABLE_SIMPLE_INFO:			// 10005
					return TableSimpleInfo;
				case TLVType.DN_TLV_MONEY_CHANGE_INFO:			// 10006
					return PlayerMoneyChangeInfo;
				case TLVType.DN_TLV_COUNT_NORMAL_ITEM_CHANGE_INFO:	// 10007
					return TPlayerCountNormalItemChangeInfo;
				case TLVType.DN_TLV_GAME_MSG_INFO:				// 10008
					return GameMsgInfo;
				case TLVType.DN_TLV_LOCK_INFO:					// 10009
					return LockInfo;
				case TLVType.DN_TLV_BASE_GAME_CFG:				// 10010
					return BaseGameCfgData;
				case TLVType.DN_TLV_AVATAR_CHANGE_INFO:			// 10011
					return TPlayerAvatarChangeInfo;
				case TLVType.DN_TLV_PLAYER_CAPABILITY:			// 10012
					return PlayerCapability;
				case TLVType.DN_TLV_EXIT_PLAYER_INFO:			// 10013
					return ExitPlayerInfo;
				case TLVType.DN_TLV_GAME_LOGIC_MSG:				// 10014
					return null;
				case TLVType.DN_TLV_GAME_SCORE_MSG:				// 10015
					return GameScoreValue;
				default:
					throw new Error("typeTLV [" + typeTLV + "] NOT Match any TLVValue.");
			}
		}
	}
}