package sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import resource.ResManager;

	public class SoundManager
	{
		private var _bgMusicSdc:SoundChannel;
		
		public function SoundManager(inner:PrivateInner)
		{
		}		
		
		private static var _instance:SoundManager = null;
		public static function instance() : SoundManager
		{
			if (!_instance)
			{
				_instance = new SoundManager(new PrivateInner());
			}
			
			return _instance;
		}
		
		public function playBgMusic() : void
		{
			if (!_bgMusicSdc)
			{
				var sd:Sound = ResManager.instance().getResourceDev("sound.bg");
				if (sd)
				{
					_bgMusicSdc = sd.play(0, 1);
				}
			}		
		}
		
		public function stopBgMusic() : void
		{
			if (_bgMusicSdc)
			{
				_bgMusicSdc.stop();
				
				_bgMusicSdc = null;
			}
		}

		public function playButtonClick() : void
		{
			playOnce("sound.button_click");			
		}

		public function playTimerRun() : void
		{
			playOnce("sound.timer_run");
		}

		public function playTimerWarning() : void
		{
			playOnce("sound.timer_warning");
		}

		public function playNotifyStart() : void
		{
			playOnce("sound.notify_start");
		}

		public function playNotifyEnterRoom() : void
		{
			playOnce("sound.notify_enter_room");
		}

		public function playSelectCard() : void
		{
			playOnce("sound.select_card");
		}

		public function playBet() : void
		{
			playOnce("sound.bet");
		}

		public function playDealCard() : void
		{
			playOnce("sound.deal_card");
		}

		public function playGiveCard() : void
		{
			playOnce("sound.give_card");
		}

		public function playGameWin() : void
		{
			playOnce("sound.game_win");
		}

		public function playGameLose() : void
		{
			playOnce("sound.game_lose");
		}


		private function playOnce(id:String) : void
		{
			var sd:Sound = ResManager.instance().getResourceDev(id);
			if (sd)
			{
				sd.play();
			}
		}
	}
}

class PrivateInner
{
	
}