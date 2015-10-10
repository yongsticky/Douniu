package resource.dev
{
	public class SoundRes extends Resource
	{
		[Embed(source="../../../resource/sound/res_sound.swf#niujiaosheng")]
		private static const NiuJiaoShengSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#daojishijingshi")]
		private static const DaoJiShiJingShi:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#kaishitishi")]
		private static const KaiShiTiShiSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#jinfangjiantishiyin")]
		private static const JinFangJianTiShiYinSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#liangpai")]
		private static const LiangPaiSound:Class;		
		[Embed(source="../../../resource/sound/res_sound.swf#bgsound")]
		private static const BgSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#xuanpaisheng")]
		private static const XuanPaiShengSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#paijushengli")]
		private static const PaiJuShengLiSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#button_click")]
		private static const ButtonClickSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#paijushibai")]
		private static const PaiJuShiBaiSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#zhongjiang")]
		private static const ZhongJiangSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#jishisheng")]
		private static const JiShiShengSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#xiazhusheng")]
		private static const XiaZhuShengSound:Class;
		[Embed(source="../../../resource/sound/res_sound.swf#fapaisheng")]
		private static const FaPaiShengSound:Class;
		
		public function SoundRes()
		{
			super();
			
			add("sound.mooing", new NiuJiaoShengSound());
			add("sound.timer_warning", new DaoJiShiJingShi());
			add("sound.notify_start", new KaiShiTiShiSound());
			add("sound.notify_enter_room", new JinFangJianTiShiYinSound());
			add("sound.give_card", new LiangPaiSound());
			add("sound.bg", new BgSound());
			add("sound.select_card", new XuanPaiShengSound());
			add("sound.game_win", new PaiJuShengLiSound());
			add("sound.button_click", new ButtonClickSound());
			add("sound.game_lose", new PaiJuShiBaiSound());
			add("sound.lottery", new ZhongJiangSound());
			add("sound.timer_run", new JiShiShengSound());
			add("sound.bet", new XiaZhuShengSound());
			add("sound.deal_card", new FaPaiShengSound());
		}
	}
}