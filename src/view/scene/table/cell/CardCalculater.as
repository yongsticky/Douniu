package view.scene.table.cell
{
	import douniu.NiuCard;
	
	import resource.ResManager;
	
	import starling.text.TextField;
	
	import view.framework.ExImage;
	import view.framework.ExSprite;
	
	public class CardCalculater extends ExSprite
	{
		private var _bg:ExImage;
		
		private var _numbers:Array;
		
		static private const SIZE:int = 4; 
		static private const POS_DATA:Array = [{x:10, y:34},	{x:74, y:34},{x:138, y:34}, {x:202, y:34}]; 
			
		
		public function CardCalculater(name:String=null)
		{		
			super(name);
		}
		
		override protected function createChildren():void
		{
			_bg = new ExImage(ResManager.instance().getResource("ui.calc_bg"));
			addChild(_bg);
			
			_numbers = new Array(SIZE);
			
			for (var i:int = 0; i < SIZE; ++i)
			{
				var num:TextField = new TextField(38, 38, "", "", 24, 0x00000000); 
				_numbers[i] = num;
				
				num.x = POS_DATA[i].x;
				num.y = POS_DATA[i].y;
				num.visible = false;
				addChild(num);				
			}
		}		
			
		public function update(data:Vector.<int>) : void
		{
			
			var count:int = 0;
			for (var i:int = 0; i < SIZE-1; ++i)
			{
				var num:TextField = _numbers[i] as TextField;
				if (data[i] > 0)
				{
					num.text = NiuCard.getValue(data[i]).toString();
					num.visible = true;
					
					count += NiuCard.getValue(data[i]);
				}
				else
				{
					num.visible = false;
				}
			}			
			
			
			var countNum:TextField = _numbers[SIZE-1] as TextField;
			if (count > 0)
			{				
				countNum.text = count.toString();
				countNum.visible = true;
			}
			else
			{
				countNum.visible = false;
			}
		}	
	}
}