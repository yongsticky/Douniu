package server
{		
	import camu.logger.ILogger;
	import camu.logger.LEVEL;
	import camu.logger.Logger;
	import camu.net.PacketEvent;
	import camu.net.PacketEventTypeUtil;
	
	import factory.NiuObjectFactory;
	import packet.game.message.Login.Response_Login;
	import packet.game.message.Logout.Request_Logout;
	import packet.game.message.Logout.Response_Logout;
	import packet.game.message.Ready.Request_Ready;
	import packet.game.message.Ready.Response_Ready;
	import packet.game.message.Sitdown.Request_Sitdown;
	import packet.game.message.Sitdown.Response_Sitdown;
	import packet.game.message.Standup.Request_Standup;
	import packet.game.message.Standup.Response_Standup;
	import packet.game.message.WrapperMessage.Response_WrapperMessage;
	import packet.protocol.NiuResponsePacket;

	public class NiuResponseReceiver
	{
		private var _logger:ILogger;		
		
		public function NiuResponseReceiver(inner:PrivateInner)
		{
			_logger = Logger.createLogger(NiuResponseReceiver, LEVEL.DEBUG);
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
		
		public function initReceiver() : void
		{			
			addReveiver(Response_WrapperMessage, onReceive_WrapperMessage);
			addReveiver(Response_Login, onReceive_Login);
			addReveiver(Response_Logout, OnReceive_Logout);
			addReveiver(Response_Sitdown, onReceive_Sitdown);
			addReveiver(Response_Ready, onReceive_Ready);
			addReveiver(Response_Standup, onReceive_Standup);
		}		
		
		
		private function addReveiver(cls:Class, f:Function) : void
		{			
			var eventType:String = PacketEventTypeUtil.getEventTypeByClass(cls);
			_logger.log("addReveiver, event = [", eventType, "]", LEVEL.DEBUG);
			
			NiuServerConnector.instance().addEventListener(eventType, f);			
		}
		
		protected function onReceive_Login(event:PacketEvent) : void
		{
			_logger.log("onReceive_Login Enter.", LEVEL.DEBUG);			
			
			var resp:Response_Login = event.packet as Response_Login;
			
			printResponseResult(resp);
			
			var sitdownRequest:Request_Sitdown = NiuObjectFactory.instance().createInstance(Request_Sitdown);	
			sitdownRequest.csHeader.dialog_id = resp.player_id;
			sitdownRequest.csHeader.uin = resp.csHeader.uin;
			sitdownRequest.sitdown_flag = 3;
			
			
			NiuRequestSender.instance().sendRequest(sitdownRequest);
		}
		
		protected function onReceive_WrapperMessage(event:PacketEvent) : void
		{
			_logger.log("onReceive_WrapperMessage Enter.", LEVEL.DEBUG);
				
			var wrapperMessage:Response_WrapperMessage = event.packet as Response_WrapperMessage;
			if (wrapperMessage)
			{
				_logger.log("onReceive_WrapperMessage, wrapper msg num:", wrapperMessage.packet_vec.length, LEVEL.DEBUG);
				
				for each(var resp:NiuResponsePacket in wrapperMessage.packet_vec)
				{					
					var responsePacket:NiuResponsePacket = resp as NiuResponsePacket;
					responsePacket.csHeader.copy(wrapperMessage.csHeader);
					_logger.log("onReceive_WrapperMessage, prepare to dispatch, msgid=", responsePacket.msgHeader.msg_id, LEVEL.DEBUG);
					NiuServerConnector.instance().dispatchWarpperMessagePacket(resp);	
				}				
			}
		}
		
		protected function OnReceive_Logout(event:PacketEvent) : void
		{
			_logger.log("onReceive_Logout Enter.", LEVEL.DEBUG);
			var resp:NiuResponsePacket = event.packet as NiuResponsePacket;
			
			printResponseResult(resp);			
		}
		
		protected function onReceive_Sitdown(event:PacketEvent) : void
		{
			_logger.log("onReceive_Sitdown Enter.", LEVEL.DEBUG);
			
			var resp:Response_Sitdown = event.packet as Response_Sitdown;
			
			printResponseResult(resp);			

			var readyRequest:Request_Ready = NiuObjectFactory.instance().createInstance(Request_Ready);
				
			readyRequest.csHeader.dialog_id = resp.csHeader.dialog_id;
			readyRequest.csHeader.uin = resp.csHeader.uin;
			readyRequest.ready_mode = 0;
			readyRequest.room_id = resp.room_id;
			readyRequest.table_id = resp.table_id;		
				
			NiuRequestSender.instance().sendRequest(readyRequest);
		}
		
		protected function onReceive_Ready(event:PacketEvent) : void
		{
			_logger.log("onReceive_Ready Enter.", LEVEL.DEBUG);
			var resp:NiuResponsePacket = event.packet as NiuResponsePacket;
			printResponseResult(resp);
			
			var standupRequest:Request_Standup = NiuObjectFactory.instance().createInstance(Request_Standup);
			standupRequest.csHeader.copy(resp.csHeader);
			standupRequest.room_id = 76;
			standupRequest.standup_flag = 0;
			
			NiuRequestSender.instance().sendRequest(standupRequest);			
		}
		
		protected function onReceive_Standup(event:PacketEvent) : void
		{
			_logger.log("onReceive_Standup Enter.", LEVEL.DEBUG);
			
			var resp:NiuResponsePacket = event.packet as NiuResponsePacket; 
			printResponseResult(resp);
			
			var logoutReqeust:Request_Logout = NiuObjectFactory.instance().createInstance(Request_Logout);
			logoutReqeust.csHeader.copy(resp.csHeader);
			logoutReqeust.reason = 0;
			
			NiuRequestSender.instance().sendRequest(logoutReqeust);
			
		}
		
		private function printResponseResult(responsePacket:NiuResponsePacket) : void
		{
			if (responsePacket)
			{
				_logger.log("RESPONSE: msgId=[", responsePacket.msgHeader.msg_id, "], result=[", responsePacket["rresult"]["result_id"], "].", LEVEL.INFO);
			}			
		}			
	}
}

class PrivateInner
{
	
}