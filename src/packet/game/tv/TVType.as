package packet.game.tv
{
	import camu.errors.AbstractClassError;
	import camu.errors.UnhandledBranchError;
	
	import packet.game.tv.value.NotifyBet;
	import packet.game.tv.value.NotifyBetDetail;
	import packet.game.tv.value.NotifyDealerDetail;
	import packet.game.tv.value.NotifyFinish;
	import packet.game.tv.value.NotifyGive;
	import packet.game.tv.value.NotifyRobDealer;
	import packet.game.tv.value.NotifyStartTimer;
	import packet.game.tv.value.RequestBet;
	import packet.game.tv.value.RequestGive;
	import packet.game.tv.value.RequestRobDealer;

	/*
	
	ID_SO_NOTIFY_ROB_DEALER = 1, // 通知玩家抢庄，S-C， 告诉玩家可以抢庄的倍数有多少种，经典场-只有一倍的一种，看牌场-有多种，通过TLV告诉抢庄倒计时的时间，如果是看牌场，则通过TLV发4张牌
	ID_SO_REQUEST_DEALER = 2, // 请求抢庄,c-s
	ID_SO_NOTIFY_DEALER_DETAIL = 3, // 通知玩家抢庄过程，每个玩家抢庄的过程，都要知会到其他玩家，s-c，同时，如果所有玩家强装完毕后，通过TLV告诉谁是庄家，其他玩家可以押注的倍数，以及押注倒计时的时间
	ID_SO_NOTIFY_BET = 4, // 通知玩家押注,s-c
	ID_SO_REQUEST_BET = 5, // 请求押注,c-s
	ID_SO_NOTIFY_BET_DETAIL = 6, // 通知玩家押注过程，每个玩家押注的过程，都要知会到其他玩家，s-c，如果所有玩家都押注完毕，会在TLV中附带玩家发牌信息，以及玩家出牌倒计时的时间
	ID_SO_NOTIFY_GIVE = 7, // 通知玩家出牌,s-c
	ID_SO_REQUEST_GIVE = 8, // 请求出牌，客户端算完牛牛后，出到服务器端,c-s
	ID_SO_NOTIFY_FINISH = 9, // 通知结算,s-c，每个玩家将出牌信息送到服务器后，都需要给玩家发送结算信息，如果所有玩家结算完毕，则通过TLV告诉客户端这一局已经结束，重新倒计时开始
	
	*/
	public class TVType
	{
		public static const SO_REQUEST_DEALER:int = 2;
		public static const SO_REQUEST_BET:int = 5;
		public static const SO_REQUEST_GIVE:int = 8;		
		
		public static const SO_NOTIFY_ROB_DEALER:int = 1;
		public static const SO_NOTIFY_DEALER_DETAIL:int = 3;		 
		public static const SO_NOTIFY_BET:int = 4;
		public static const SO_NOTIFY_BET_DETAIL:int = 6;
		public static const SO_NOTIFY_GIVE:int = 7;
		public static const SO_NOTIFY_FINISH:int = 9;
		public static const SO_NOTIFY_START_TIME:int = 10;
		
		public function TVType()
		{
			throw new AbstractClassError();
		}
		
		
		public static function TVTypeToClass(tvType:int) : Class
		{
			switch(tvType)
			{
				case SO_REQUEST_DEALER:
					return RequestRobDealer;
				case SO_REQUEST_BET:
					return RequestBet;
				case SO_REQUEST_GIVE:
					return RequestGive;
				case SO_NOTIFY_ROB_DEALER:
					return NotifyRobDealer;
				case SO_NOTIFY_DEALER_DETAIL:
					return NotifyDealerDetail;
				case SO_NOTIFY_BET:
					return NotifyBet;
				case SO_NOTIFY_BET_DETAIL:
					return NotifyBetDetail;
				case SO_NOTIFY_GIVE:
					return NotifyGive;
				case SO_NOTIFY_FINISH:
					return NotifyFinish;
				case SO_NOTIFY_START_TIME:
					return NotifyStartTimer;
				default:
					throw new UnhandledBranchError("tvType [" + tvType + "] NOT Match any TLVValue.");					
			}
		}
	}
}