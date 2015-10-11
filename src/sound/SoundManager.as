package sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import camu.errors.NullObjectError;
	
	import global.UserSettings;
	import global.UserSettingsEvent;
	
	import resource.ResManager;

	public class SoundManager
	{
		private var _bgMusicSdc:SoundChannel = null;
		private var _bgMusicPlayPostion:Number = 0;
		
		private var _effSoundTransform:SoundTransform = null;
		
		private var _isBgMusicMute:Boolean = false;
		private var _bgMusicVolume:Number = 1;
				
		private var _isEffSoundMute:Boolean = false;
		private var _effSoundVolume:Number = 1;
		
		public function SoundManager(inner:PrivateInner)
		{
			UserSettings.instance().addEventListener(UserSettingsEvent.CHANGED, onUserSettingsChanged);
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
		
		private function onUserSettingsChanged(event:UserSettingsEvent) : void
		{	
			if (!event)
			{
				throw new NullObjectError();
			}
			
			switch(event.changedId)
			{
				case UserSettings.BG_MUTE:					
					_isBgMusicMute = Boolean(event.changedValue);
					_isBgMusicMute ? stopBgMusic():playBgMusic();
					break;
				
				case UserSettings.BG_VOLUME:
					_bgMusicVolume = Number(event.changedValue) / 10;
					applyBgMusicVolume();
					break;
				
				case UserSettings.EFF_MUTE:	
					_isEffSoundMute = Boolean(event.changedValue);
					break;
				
				case UserSettings.EFF_VOLUME:
					_effSoundVolume = Number(event.changedValue) / 10;
					break;
				
				default:
					break;
			}
		}
			
				
		public function playBgMusic() : void
		{
			if (_isBgMusicMute)
			{
				return;
			}
			
			if (!_bgMusicSdc)
			{
				var sd:Sound = ResManager.instance().getResourceDev("sound.bg");
				if (sd)
				{
					_bgMusicSdc = sd.play(_bgMusicPlayPostion, 1, new SoundTransform(_bgMusicVolume));
				}
			}		
		}
		
		public function stopBgMusic() : void
		{
			if (_bgMusicSdc)
			{
				_bgMusicPlayPostion = _bgMusicSdc.position;
				_bgMusicSdc.stop();
				
				_bgMusicSdc = null;
			}
		}
		
		public function applyBgMusicVolume() : void
		{
			if (_bgMusicSdc)
			{
				_bgMusicSdc.soundTransform.volume = _bgMusicVolume;
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

		public function playNotifyBetDetail() : void
		{
			playOnce("sound.notify_bet_detail");
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
			if (!_isEffSoundMute)
			{
				var sd:Sound = ResManager.instance().getResourceDev(id);
				if (sd)
				{
					if (!_effSoundTransform)
					{
						_effSoundTransform = new SoundTransform(_effSoundVolume);
					}
					else
					{
						_effSoundTransform.volume = _effSoundVolume;
					}
					
					sd.play(0, 0, _effSoundTransform);
				}	
			}			
		}
	}
}

class PrivateInner
{
	
}