package view.scene.table.control
{
	import douniu.NiuCard;
	
	import resource.ResManager;
	
	import starling.textures.Texture;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class Control_OtherPlayerCards extends ExSprite
	{		
		private static const MAX_CARDS_NUM:int = 5;
		
		public function Control_OtherPlayerCards()
		{
			super();			
		}
		
		override protected function createChildren() : void
		{
			var resManager:ResManager = ResManager.instance();				
			
			var backSideTexture:Texture = Texture.fromBitmapData(resManager.getResourceDev("poker.bei"));
			var startX:int = 0;
			for (var i:int = 0; i < MAX_CARDS_NUM; i++)
			{
				var c:ExImage = new ExImage(backSideTexture);
				c.y = 0;
				c.x = startX;				
				addChild(c);
				
				startX += 16;
			}
		}
		
		override protected function layoutChildren() : void
		{
			super.layoutChildren();
		}
				
		public function setCardShow(index:int, show:Boolean, card:NiuCard) : void
		{
			
		}
	}
}