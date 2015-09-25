package resource.dev
{
	import flash.utils.Dictionary;

	

	public class TableSceneRes
	{		
		[Embed(source="../../../resource/table/res_table.swf#top_banner.png")]
		private static const TopBannerPNG:Class;
	
		[Embed(source="../../../resource/table/res_table.swf#bg.png")]
		private static const BgPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#bg_logo.png")]
		private static const BgLogoPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#bottom_banner.png")]
		private static const BottomBannerPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#notify_bg.png")]
		private static const NotifyBgPNG:Class;		
		
		[Embed(source="../../../resource/table/res_table.swf#name.png")]
		private static const NamePNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#chips.png")]
		private static const ChipsPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#setting.png")]
		private static const SettingPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_0.png")]
		private static const Timer0PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_1.png")]
		private static const Timer1PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_2.png")]
		private static const Timer2PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_3.png")]
		private static const Timer3PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_4.png")]
		private static const Timer4PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_5.png")]
		private static const Timer5PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_6.png")]
		private static const Timer6PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_7.png")]
		private static const Timer7PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_8.png")]
		private static const Timer8PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_9.png")]
		private static const Timer9PNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#timer_bg.png")]
		private static const TimerBgPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#ask_rob_no.png")]
		private static const AskRobNobPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#ask_rob_1x.png")]
		private static const AskRob1xPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#ask_rob_1x_disable.png")]
		private static const AskRob1xDisablePNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#ask_rob_2x.png")]
		private static const AskRob2xPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#ask_rob_2x_disable.png")]
		private static const AskRob2xDisablePNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#ask_rob_4x.png")]
		private static const AskRob4xPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#ask_rob_4x_disable.png")]
		private static const AskRob4xDisablePNG:Class;
				
		[Embed(source="../../../resource/table/res_table.swf#notify_norob.png")]
		private static const NotifyNorobPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#notify_rob.png")]
		private static const NotifyRobPNG:Class;		
		
		[Embed(source="../../../resource/table/res_table.swf#rob_1x.png")]
		private static const Rob1xPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#rob_2x.png")]
		private static const Rob2xPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#rob_4x.png")]
		private static const Rob4xPNG:Class;
				
		[Embed(source="../../../resource/table/res_table.swf#vip_mall.png")]
		private static const VipMallPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#wait_next.png")]
		private static const WaitNextPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#wait_next.png")]
		private static const WaitBetPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#wait_rob.png")]
		private static const WaitRobDealerPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#wait_rob.png")]
		private static const WaitGivePNG:Class;				
		
		[Embed(source="../../../resource/table/res_table.swf#viewer.png")]
		private static const ViewerPNG:Class;	
		
		[Embed(source="../../../resource/table/res_table.swf#banker.png")]
		private static const DealerPNG:Class;
		
		[Embed(source="../../../resource/table/res_table.swf#bet.png")]
		private static const BetPNG:Class;

		private var _res:Dictionary;

		public function TableSceneRes()
		{
			_res = new Dictionary();
			
			_res["table.top_banner"] = new TopBannerPNG();
			_res["table.bg"] = new BgPNG();
			_res["table.bg_logo"] = new BgLogoPNG();
			_res["table.bottom_banner"] = new BottomBannerPNG();
			_res["table.notify_bg"] = new NotifyBgPNG();
			_res["table.name"] = new NamePNG();
			_res["table.chips"] = new ChipsPNG();
			_res["table.setting"] = new SettingPNG();
			_res["table.timer_0"] = new Timer0PNG();
			_res["table.timer_1"] = new Timer1PNG();
			_res["table.timer_2"] = new Timer2PNG();
			_res["table.timer_3"] = new Timer3PNG();
			_res["table.timer_4"] = new Timer4PNG();
			_res["table.timer_5"] = new Timer5PNG();
			_res["table.timer_6"] = new Timer6PNG();
			_res["table.timer_7"] = new Timer7PNG();
			_res["table.timer_8"] = new Timer8PNG();
			_res["table.timer_9"] = new Timer9PNG();			
			_res["table.timer_bg"] = new TimerBgPNG();
			_res["table.ask_rob_no"] = new AskRobNobPNG();
			_res["table.ask_rob_1x"] = new AskRob1xPNG();
			_res["table.ask_rob_1x_disable"] = new AskRob1xDisablePNG();
			_res["table.ask_rob_2x"] = new AskRob2xPNG();
			_res["table.ask_rob_2x_disable"] = new AskRob2xDisablePNG();
			_res["table.ask_rob_4x"] = new AskRob4xPNG();
			_res["table.ask_rob_4x_disable"] = new AskRob4xDisablePNG();
			_res["table.notify_norob"] = new NotifyNorobPNG();
			_res["table.notify_nrob"] = new NotifyRobPNG();
			_res["table.rob_1x"] = new Rob1xPNG();
			_res["table.rob_2x"] = new Rob2xPNG();
			_res["table.rob_4x"] = new Rob4xPNG();
			_res["table.vip_mall"] = new VipMallPNG();
			_res["table.wait_next"] = new WaitNextPNG();
			_res["table.wait_rob_dealer"] = new WaitRobDealerPNG();
			_res["table.wait_bet"] = new WaitBetPNG();
			_res["table.wait_give"] = new WaitGivePNG();
			_res["table.viewer"] = new ViewerPNG();
			_res["table.dealer"] = new DealerPNG();
			_res["table.bet"] = new BetPNG();
		}

		public function getResource(id:String) : *
		{
			if (_res.hasOwnProperty(id))
			{
				return _res[id];
			}
			else
			{
				return null;
			}
		}
	}
}
