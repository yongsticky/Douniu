package view.scene.table.widget
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Widget_PlayerCards extends ExSprite
	{		
		private static const MAX_CARDS_NUM:int = 5;
		
		public function Widget_PlayerCards(name:String = null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance(); 
				
			var startX:int = 0;
			for (var i:int = 0; i < MAX_CARDS_NUM; i++)
			{
				var c:ExImage = new ExImage(resManager.getResourceDev("poker.hong.1"));				
				c.x = startX;				
				addChild(c);
				startX += 73;
			}
			
		}
		
		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
	}
}