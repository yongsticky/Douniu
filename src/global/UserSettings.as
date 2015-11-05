package global
{
	import flash.events.EventDispatcher;	
	
	import camu.errors.LowerBoundError;
	import camu.errors.UpperBoundError;
	
	public class UserSettings extends EventDispatcher
	{
		private var _bgMute:Boolean;
		private var _bgVolume:uint;
		
		private var _effMute:Boolean;
		private var _effVolume:uint;
		
		static public const BG_MUTE:int = 1;
		static public const BG_VOLUME:int = 2;
		
		static public const EFF_MUTE:int = 3;
		static public const EFF_VOLUME:int = 4;
		
		public function UserSettings(inner:PrivateInner)
		{
			super();
		}
		
		private static var _instance:UserSettings = null;
		public static function instance() : UserSettings
		{
			if (!_instance)
			{
				_instance = new UserSettings(new PrivateInner());
				_instance.defaultSettings();
			}
			
			return _instance;
		}
		
		private function defaultSettings() : void
		{
			_bgMute = false;
			_bgVolume = 5;
			
			_effMute = false;
			_effVolume = 6;
		}
		
		public function set backgroundMusicMute(value:Boolean) : void
		{
			if (_bgMute != value)
			{
				_bgMute = value;
				
				notifyChanged(BG_MUTE, _bgMute);
			}			
		}		
		
		public function get backgroundMusicMute() : Boolean
		{
			return _bgMute;
		}
		
		public function set backgoroundMusicVolume(value:uint) : void
		{
			if (value > 10)
			{
				throw new UpperBoundError();
			}
			
			if (_bgVolume != value)
			{
				_bgVolume = value;
					
				notifyChanged(BG_VOLUME, _bgVolume);
			}			
		}
		
		public function get backgoroundMusicVolume() : uint
		{
			return _bgVolume;
		}
		
		public function set effectSoundMute(value:Boolean) : void
		{
			if (_effMute != value)
			{
				_effMute = value;
				
				notifyChanged(EFF_MUTE, _effMute);
			}
		}
		
		public function get effectSoundMute() : Boolean
		{
			return _effMute;
		}
		
		public function set effectSoundVolume(value:uint) : void
		{
			if (value > 10)
			{
				throw new UpperBoundError();
			}
						
			if (_effVolume != value)
			{
				_effVolume = value;
					
				notifyChanged(EFF_VOLUME, _effVolume);
			}			
		}
		
		public function get effectSoundVolume() : uint
		{
			return _effVolume;
		}
		
		private function notifyChanged(id:int, value:*) : void
		{
			var event:UserSettingsEvent = new UserSettingsEvent(UserSettingsEvent.CHANGED);
			event.changedId_ = id;
			event.changedValue_ = value;
			
			dispatchEvent(event);
		}
	}	
}

class PrivateInner
{
	
}