package view.scene.setting.layer
{
	import global.UserSettings;
	
	import sound.SoundManager;
	
	import starling.events.Event;
	
	import view.framework.ExLayer;
	import view.widget.Widget_CheckButton;
	import view.widget.Widget_SliderControl;

	public class Layer_SettingMain extends ExLayer
	{		
		private var _bgMusicSwitcher:Widget_CheckButton;
		private var _bgMusicVolume:Widget_SliderControl;
		
		private var _effectSoundSitcher:Widget_CheckButton;
		private var _effectSoundVolume:Widget_SliderControl;
		
		public function Layer_SettingMain(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var userSettings:UserSettings = UserSettings.instance();
			
			_bgMusicSwitcher = new Widget_CheckButton(null, "背景音乐", !userSettings.backgroundMusicMute);
			_bgMusicSwitcher.x = 48;
			_bgMusicSwitcher.y = 70;
			addChild(_bgMusicSwitcher);
			_bgMusicSwitcher.addEventListener(Widget_CheckButton.STATUS, onBgMusicSwitcherStatus);
			
			_bgMusicVolume = new Widget_SliderControl(null, userSettings.backgoroundMusicVolume);
			_bgMusicVolume.x = 48;
			_bgMusicVolume.y = 106;
			addChild(_bgMusicVolume);
			_bgMusicVolume.addEventListener(Widget_SliderControl.STATUS, onBgMusicVolumeStatus);
			_bgMusicVolume.enabled = !userSettings.backgroundMusicMute;
		
			
			_effectSoundSitcher = new Widget_CheckButton(null, "游戏音效", !userSettings.effectSoundMute);
			_effectSoundSitcher.x = 48;
			_effectSoundSitcher.y = 160;
			addChild(_effectSoundSitcher);
			_effectSoundSitcher.addEventListener(Widget_CheckButton.STATUS, onEffectSoundSwitcherStatus);
			
			_effectSoundVolume = new Widget_SliderControl(null, userSettings.effectSoundVolume);
			_effectSoundVolume.x = 48;
			_effectSoundVolume.y = 196;
			addChild(_effectSoundVolume);
			_effectSoundVolume.addEventListener(Widget_SliderControl.STATUS, onEffectSoundVolumeStatus);
			_effectSoundVolume.enabled = !userSettings.effectSoundMute;
		}		
	
		
		private function onBgMusicSwitcherStatus(event:Event):void
		{
			 var status:Boolean = Boolean(event.data);
			
			 _bgMusicVolume.enabled = status;			 
			 
			UserSettings.instance().backgroundMusicMute = !status;
			
			SoundManager.instance().playButtonClick();
		}
		
		private function onBgMusicVolumeStatus(event:Event):void
		{
			UserSettings.instance().backgoroundMusicVolume = int(event.data);	
		}
		
		
		
		private function onEffectSoundSwitcherStatus(event:Event):void
		{
			var status:Boolean = Boolean(event.data);
			
			_effectSoundVolume.enabled = status;			 
			
			UserSettings.instance().effectSoundMute = !status;
			
			SoundManager.instance().playButtonClick();			
		}
		
		private function onEffectSoundVolumeStatus(event:Event):void
		{
			UserSettings.instance().effectSoundVolume = int(event.data);				
		}		
	}
}