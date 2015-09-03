package resource.dev
{
	import flash.utils.Dictionary;

	

	public class TableSceneRes
	{

		[Embed(source="../../../resource/table/res_table.swf#ask_rob.png")]
		private static const AskRobPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#banner.png")]
		private static const BannerPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#bg.png")]
		private static const BgPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#bg_text.png")]
		private static const BgTextPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#bottom.png")]
		private static const BottomPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#broad_bg.png")]
		private static const BroadBgPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#btn_norob.png")]
		private static const BtnNorobPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#coin.png")]
		private static const ChipsPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#rob_1.png")]
		private static const Rob1PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#rob_2.png")]
		private static const Rob2PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#rob_4.png")]
		private static const Rob4PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#setting.png")]
		private static const SettingPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_0.png")]
		private static const Time0PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_1.png")]
		private static const Time1PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_2.png")]
		private static const Time2PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_3.png")]
		private static const Time3PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_4.png")]
		private static const Time4PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_5.png")]
		private static const Time5PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_6.png")]
		private static const Time6PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_7.png")]
		private static const Time7PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_8.png")]
		private static const Time8PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_9.png")]
		private static const Time9PNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#time_bg.png")]
		private static const TimeBgPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#tip_norob.png")]
		private static const TipNorobPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#vip_mall.png")]
		private static const VipMallPNG:Class;
		[Embed(source="../../../resource/table/res_table.swf#wait_rob.png")]
		private static const WaitRobPNG:Class;			

		private var _res:Dictionary;

		public function TableSceneRes()
		{
			_res = new Dictionary();

			_res["table.askrob"] = new AskRobPNG();			
			_res["table.banner"] = new BannerPNG();
			_res["table.bg"] = new BgPNG();
			_res["table.bg_text"] = new BgTextPNG();
			_res["table.bottom"] = new BottomPNG();
			_res["table.broad_bg"] = new BroadBgPNG();
			_res["table.btn_norob"] = new BtnNorobPNG();
			_res["table.chips"] = new ChipsPNG();
			_res["table.rob_1"] = new Rob1PNG();
			_res["table.rob_2"] = new Rob2PNG();
			_res["table.rob_4"] = new Rob4PNG();
			_res["table.setting"] = new SettingPNG();
			_res["table.time_0"] = new Time0PNG();
			_res["table.time_1"] = new Time1PNG();
			_res["table.time_2"] = new Time2PNG();
			_res["table.time_3"] = new Time3PNG();
			_res["table.time_4"] = new Time4PNG();
			_res["table.time_5"] = new Time5PNG();
			_res["table.time_6"] = new Time6PNG();
			_res["table.time_7"] = new Time7PNG();
			_res["table.time_8"] = new Time8PNG();
			_res["table.time_9"] = new Time9PNG();			
			_res["table.time_bg"] = new TimeBgPNG();
			_res["table.tip_norob"] = new TipNorobPNG();
			_res["table.vip_mall"] = new VipMallPNG();
			_res["table.wait_rob"] = new WaitRobPNG();
			
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
