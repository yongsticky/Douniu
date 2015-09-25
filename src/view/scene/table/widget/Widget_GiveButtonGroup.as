package view.scene.table.widget
{

	
	import starling.display.Button;
	import starling.textures.Texture;
	
	import view.framework.ExSprite;
	
	public class Widget_GiveButtonGroup extends ExSprite
	{
		private var _giveNiu:Button;
		private var _giveNone:Button;
		
		public function Widget_GiveButtonGroup(name:String=null)
		{
			super(name);
		}		
		
		override protected function createChildren() : void
		{
			_giveNiu = new Button(Texture.fromColor(100, 48, 0xFF00FF00), "有牛");			
			addChild(_giveNiu);
			
			_giveNone = new Button(Texture.fromColor(100, 48, 0xFFFF0000), "没有牛");
			_giveNone.y = 58;			
			addChild(_giveNone);
		}
		
		public function setGiveNiuEnabled(enabled:Boolean) : void
		{
			_giveNiu.enabled = enabled;
		}	
		
		public function isGiveNiuButton(btn:Button) : Boolean
		{
			if (btn == _giveNiu)
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