package resource.dev
{
	public class HallSceneRes extends Resource
	{
		[Embed(source="../../../resource/hall/res_hall.swf#bg.png")]
		private static const BgPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#top_banner.png")]
		private static const TopBannerPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#chips.png")]
		private static const ChipsPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#name.png")]
		private static const NamePNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#room_bg.png")]
		private static const RoomBgPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#type1_room.png")]
		private static const Type1RoomPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#type2_room.png")]
		private static const Type2RoomPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#type3_room.png")]
		private static const Type3RoomPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#setting.png")]
		private static const SettingPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#ticket.png")]
		private static const TicketPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#room_enter_error.png")]
		private static const RoomEnterErrorPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#user.png")]
		private static const UserPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#vip_mall.png")]
		private static const VipMallPNG:Class;

		[Embed(source="../../../resource/hall/res_hall.swf#vip_mall_hover.png")]
		private static const VipMallHoverHPNG:Class;
		
		//private var _res:Dictionary;

		public function HallSceneRes()
		{
			//_res = new Dictionary();

			super();

			add("hall.bg", new BgPNG());
			add("hall.top_banner", new TopBannerPNG());
			add("hall.chips", new ChipsPNG());
			add("hall.name", new NamePNG());
			add("hall.room_bg", new RoomBgPNG());
			add("hall.type1_room", new Type1RoomPNG());
			add("hall.type2_room", new Type2RoomPNG());
			add("hall.type3_room", new Type3RoomPNG());
			add("hall.setting", new SettingPNG());
			add("hall.ticket", new TicketPNG());
			add("hall.room_enter_error", new RoomEnterErrorPNG());
			add("hall.user", new UserPNG());
			add("hall.vip_mall", new VipMallPNG());
			add("hall.vip_mall_hover", new VipMallHoverHPNG());

			/*
			_res["hall.bg"] = new BgPNG();
			_res["hall.top_banner"] = new TopBannerPNG();
			_res["hall.chips"] = new ChipsPNG();
			_res["hall.name"] = new NamePNG();
			_res["hall.room_bg"] = new RoomBgPNG();
			_res["hall.type1_room"] = new Type1RoomPNG();
			_res["hall.type2_room"] = new Type2RoomPNG();
			_res["hall.type3_room"] = new Type3RoomPNG();
			_res["hall.setting"] = new SettingPNG();
			_res["hall.ticket"] = new TicketPNG();
			_res["hall.room_enter_error"] = new RoomEnterErrorPNG();
			_res["hall.user"] = new UserPNG();
			_res["hall.vip_mall"] = new VipMallPNG();
			_res["hall.vip_mall_hover"] = new VipMallHoverHPNG();
			*/
		}

		/*
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
		*/
	}
}