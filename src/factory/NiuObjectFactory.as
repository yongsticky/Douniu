package factory
{	
	import camu.object.ObjectFactory;
	
	import controller.NiuNotification;
	
	import packet.game.message.Login.Request_Login;
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Logout.Request_Logout;
	import packet.game.message.Logout.Response_Logout;
	import packet.game.message.Notify.Response_GameNotify;
	import packet.game.message.Notify.TGameEvent;
	import packet.game.message.Play.Request_Play;
	import packet.game.message.Play.Response_Play;
	import packet.game.message.Ready.Request_Ready;
	import packet.game.message.Ready.Response_Ready;
	import packet.game.message.Sitdown.Request_Sitdown;
	import packet.game.message.Sitdown.Response_Sitdown;
	import packet.game.message.Standup.Request_Standup;
	import packet.game.message.Standup.Response_Standup;
	import packet.game.message.Hello.Request_Hello;
	import packet.game.message.Hello.Response_Hello;
	import packet.game.message.WrapperMessage.Response_WrapperMessage;
	import packet.game.tlv.UnionTLV;
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
	import packet.game.tlv.value.TAppointmentKey;
	import packet.game.tlv.value.TClientInfo;
	import packet.game.tlv.value.TCometeBuffer;
	import packet.game.tlv.value.TDNPlayInfo;
	import packet.game.tlv.value.TDealerInfo;
	import packet.game.tlv.value.TMatchTickKey;
	import packet.game.tlv.value.TMultipleInfo;
	import packet.game.tlv.value.TPlayerAvatarChangeInfo;
	import packet.game.tlv.value.TPlayerCountNormalItemChangeInfo;
	import packet.game.tlv.value.TPlayerKickOutInfo;
	import packet.game.tlv.value.TTilesInfo;
	import packet.game.tlv.value.TTimerInfo;
	import packet.game.tlv.value.TableSimpleInfo;
	import packet.game.tv.UnionTV;
	import packet.game.tv.value.FinishInfo;
	import packet.game.tv.value.NotifyBet;
	import packet.game.tv.value.NotifyBetDetail;
	import packet.game.tv.value.NotifyDealerDetail;
	import packet.game.tv.value.NotifyFinish;
	import packet.game.tv.value.NotifyGive;
	import packet.game.tv.value.NotifyRobDealer;
	import packet.game.tv.value.RequestBet;
	import packet.game.tv.value.RequestDealer;
	import packet.game.tv.value.RequestGive;
		
		
	public class NiuObjectFactory extends ObjectFactory
	{		
		public function NiuObjectFactory(inner:PrivateInner)
		{
			super(null);				
			
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
			registerClass(Request_Hello);
			registerClass(Response_Hello);
			registerClass(Response_GameNotify);
			registerClass(Request_Play);
			registerClass(Response_Play);			
			
			registerClass(UnionTLV);			
			registerClass(TAppointmentKey);
			registerClass(TCometeBuffer);
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
			registerClass(TGameEvent);						
			
			registerClass(UnionTV);
			registerClass(RequestBet);
			registerClass(RequestDealer);
			registerClass(RequestGive);
			registerClass(NotifyBet);
			registerClass(NotifyBetDetail);
			registerClass(NotifyDealerDetail);
			registerClass(NotifyFinish);
			registerClass(NotifyGive);
			registerClass(NotifyRobDealer);			
			
			registerClass(TTilesInfo);
			registerClass(TMultipleInfo);
			registerClass(TDealerInfo);
			registerClass(TTimerInfo);
			registerClass(FinishInfo);
						
			registerClass(NiuNotification);
		}
		
		private static var _instance:NiuObjectFactory = null;
		public static function instance() : NiuObjectFactory
		{
			if (!_instance)
			{
				_instance = new NiuObjectFactory(new PrivateInner());
			}
			
			return _instance;
		}
	}
}

class PrivateInner
{
	
}