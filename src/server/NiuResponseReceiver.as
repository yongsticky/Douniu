package server
{	
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.PacketEvent;
	import camu.net.PacketEventTypeUtil;
	
	import controller.NiuNotification;
	
	import facade.NiuApplicationFacade;
	import facade.NiuNotificationHandlerConstant;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Logout.Request_Logout;
	import packet.game.message.Logout.Response_Logout;
	import packet.game.message.Notify.Notify_DouniuEvent;
	import packet.game.message.Notify.Notify_GameEvent;
	import packet.game.message.Play.Response_Play;
	import packet.game.message.Ready.Response_Ready;
	import packet.game.message.Sitdown.Response_Sitdown;
	import packet.game.message.Standup.Request_Standup;
	import packet.game.message.Standup.Response_Standup;
	import packet.game.message.WrapperMessage.Response_WrapperMessage;
	import packet.protocol.NiuResponsePacket;

	public class NiuResponseReceiver
	{
		protected var _logger:ILogger;
		
		protected var _mediator:NiuServerMediator;
		
		
		public function NiuResponseReceiver(inner:PrivateInner)
		{
			_logger = Logger.createLogger(NiuResponseReceiver, LEVEL.INFO);		
			
			_mediator = new NiuServerMediator();
		}
		
		private static var _instance:NiuResponseReceiver = null;
		public static function instance() : NiuResponseReceiver
		{
			if (!_instance)
			{
				_instance = new NiuResponseReceiver(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function initReceivers() : void
		{			
			addReceiver(Response_WrapperMessage, onReceive_WrapperMessage);
			addReceiver(Response_Login, onReceive_Login);
			addReceiver(Response_Logout, OnReceive_Logout);
			addReceiver(Response_Sitdown, onReceive_Sitdown);
			addReceiver(Response_Ready, onReceive_Ready);
			addReceiver(Response_Standup, onReceive_Standup);
			addReceiver(Response_Play, onReceive_Play);
			addReceiver(Notify_GameEvent, onReceive_GameNotify);
			addReceiver(Notify_DouniuEvent, onReceive_DouniuEvent);
		}
			
		
		protected function sendNotification(name:String, data:Object = null) : void
		{			
			_mediator.sendNotification(NiuNotification.createNotification(name, data));		
		}		
		
		protected function addReceiver(cls:Class, f:Function) : void
		{			
			var eventType:String = PacketEventTypeUtil.getEventTypeByClass(cls);
			_logger.log(this, "addReveiver, event = [", eventType, "]", LEVEL.INFO);
			
			NiuServerConnector.instance().addEventListener(eventType, f);			
		}
		
		protected function onReceive_Login(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_Login Enter.", LEVEL.INFO);			
			
			sendNotification(NiuNotificationHandlerConstant.LOGIN_SUCCESS, event.packet);
		}
		
		protected function onReceive_WrapperMessage(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_WrapperMessage Enter.", LEVEL.DEBUG);
				
			var wrapperMessage:Response_WrapperMessage = event.packet as Response_WrapperMessage;
			if (wrapperMessage)
			{
				_logger.log(this, "onReceive_WrapperMessage, wrapper msg num:", wrapperMessage.packet_vec.length, LEVEL.INFO);
				
				for each(var resp:NiuResponsePacket in wrapperMessage.packet_vec)
				{					
					var responsePacket:NiuResponsePacket = resp as NiuResponsePacket;
					responsePacket.csHeader.copy(wrapperMessage.csHeader);
					_logger.log(this, "onReceive_WrapperMessage, prepare to dispatch, msgid=", responsePacket.msgHeader.msg_id, LEVEL.INFO);
					NiuServerConnector.instance().dispatchWarpperMessagePacket(resp);
				}				
			}
		}	
	
		
		protected function onReceive_Sitdown(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_Sitdown Enter.", LEVEL.INFO);
						
			sendNotification(NiuNotificationHandlerConstant.SITDOWN_SUCCESS, event.packet);			
		}
		
		protected function onReceive_Ready(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_Ready Enter.", LEVEL.INFO);
			var resp:NiuResponsePacket = event.packet as NiuResponsePacket;			
			
			var standupRequest:Request_Standup = NiuObjectFactory.instance().createInstance(Request_Standup);
			standupRequest.csHeader.copy(resp.csHeader);
			standupRequest.room_id = 76;
			standupRequest.standup_flag = 0;
			
			NiuRequestSender.instance().sendRequest(standupRequest);			
		}
		
		protected function onReceive_Standup(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_Standup Enter.", LEVEL.INFO);
			
			var resp:NiuResponsePacket = event.packet as NiuResponsePacket;			
			
			var logoutReqeust:Request_Logout = NiuObjectFactory.instance().createInstance(Request_Logout);
			logoutReqeust.csHeader.copy(resp.csHeader);
			logoutReqeust.reason = 0;
			
			NiuRequestSender.instance().sendRequest(logoutReqeust);			
		}
		
		protected function onReceive_Play(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_Play Enter.", LEVEL.INFO);
			
			var resp:Response_Play = event.packet as Response_Play;
			_logger.log(this, "result_id:[", resp.rr.result_id, "]", LEVEL.INFO);
		}
		
		
		protected function onReceive_GameNotify(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_GameNotify Enter.", LEVEL.INFO);	
			sendNotification(NiuNotificationHandlerConstant.GAME_EVENT, event.packet);
		}
		
		protected function onReceive_DouniuEvent(event:PacketEvent) : void
		{
			_logger.log(this, "onReceive_DouniuEvent Enter.", LEVEL.INFO);
			
			sendNotification(NiuNotificationHandlerConstant.DOUNIU_EVENT, event.packet);
		}
		
		
		protected function OnReceive_Logout(event:PacketEvent) : void
		{
			var resp:Response_Logout = event.packet as Response_Logout;
			_logger.log(this, "onReceive_Logout, reason=", resp.logout_reason, LEVEL.INFO);				
		}					
	}
}

class PrivateInner
{
	
}