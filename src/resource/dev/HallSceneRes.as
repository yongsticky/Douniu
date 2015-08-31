package resource.dev
{
	import flash.utils.Dictionary;

	public class HallSceneRes
	{
		[Embed(source="../../../resource/hall/hallres.swf#bg.png")]
		private static const BgPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#banner.png")]
		private static const BannerPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#coin.png")]
		private static const CoinPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#name.png")]
		private static const NamePNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#room.png")]
		private static const RoomPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#roomType_1.png")]
		private static const RoomType1PNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#roomType_2.png")]
		private static const RoomType2PNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#roomType_3.png")]
		private static const RoomType3PNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#setting.png")]
		private static const SettingPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#ticket.png")]
		private static const TicketPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#tip.png")]
		private static const TipPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#user.png")]
		private static const UserPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#vipMall.png")]
		private static const VipMallPNG:Class;

		[Embed(source="../../../resource/hall/hallres.swf#vipMall_h.png")]
		private static const VipMallHPNG:Class;
		
		private var _res:Dictionary;

		public function HallSceneRes()
		{
			_res = new Dictionary();

			_res["hall.bg"] = new BgPNG();
			_res["hall.banner"] = new BannerPNG();
			_res["hall.coin"] = new CoinPNG();
			_res["hall.name"] = new NamePNG();
			_res["hall.room"] = new RoomPNG();
			_res["hall.roomType_1"] = new RoomType1PNG();
			_res["hall.roomType_2"] = new RoomType2PNG();
			_res["hall.roomType_3"] = new RoomType3PNG();
			_res["hall.setting"] = new SettingPNG();
			_res["hall.ticket"] = new TicketPNG();
			_res["hall.tip"] = new TipPNG();
			_res["hall.user"] = new UserPNG();
			_res["hall.vipMall"] = new VipMallPNG();
			_res["hall.vipMall_h"] = new VipMallHPNG();
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