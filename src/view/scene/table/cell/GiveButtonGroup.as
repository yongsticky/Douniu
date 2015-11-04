package view.scene.table.cell
{

	
	import flash.text.Font;
	
	import camu.logger.LEVEL;
	
	import resource.ResManager;
	
	import starling.display.Button;
	import starling.textures.Texture;
	
	import view.framework.ExSprite;
	
	public class GiveButtonGroup extends ExSprite
	{
		private var _niu:Button;
		private var _auto:Button;		
		
		
		public function GiveButtonGroup(name:String=null)
		{
			super(name);
		}		
		
		override protected function createChildren() : void
		{			
			var resManager:ResManager = ResManager.instance();
			
			_niu = new Button(resManager.getResource("ui.round_button_bg_red"), "", null, resManager.getResource("ui.round_button_bg_grey"));			
			_niu.fontBold = true;
			_niu.text = "有牛";
			_niu.fontSize = 16;
			_niu.fontColor = 0x671515;
			_niu.fontName = "Microsoft YaHei";
			
			addChild(_niu);
			
			_auto = new Button(resManager.getResource("ui.round_button_bg_yellow"));			
			_auto.y = 51;
			_auto.fontBold = true;
			_auto.text = "自动";
			_auto.fontSize = 16;
			_auto.fontColor = 0x671515;
			_auto.fontName = "Microsoft YaHei";
			
			addChild(_auto);
		}
		
		public function setGiveNiuEnabled(enabled:Boolean) : void
		{
			_niu.enabled = enabled;
		}	
		
		public function isGiveNiuButton(btn:Button) : Boolean
		{
			if (btn == _niu)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}