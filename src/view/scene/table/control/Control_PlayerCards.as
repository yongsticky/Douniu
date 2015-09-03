package view.scene.table.control
{
	import resource.ResManager;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Control_PlayerCards extends ExSprite
	{		
		private static const MAX_CARDS_NUM:int = 5;
		
		public function Control_PlayerCards()
		{
			super();
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