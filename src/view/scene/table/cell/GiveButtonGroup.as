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
			
			_niu = new Button(Texture.fromBitmapData(resManager.getResource("ui.round_button_bg_red")));			
			_niu.text = "有牛";
			_niu.fontSize = 18;			
			addChild(_niu);
			
			_auto = new Button(Texture.fromBitmapData(resManager.getResource("ui.round_button_bg_yellow")));			
			_auto.text = "自动";
			_auto.fontSize = 18;
			_auto.y = 51;
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