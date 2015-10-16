package view.scene.loading.layer
{
	import starling.text.TextField;
	
	import view.framework.ExLayer;
	
	public class Layer_Loading extends ExLayer
	{
		private var _percent:TextField;
		
		public function Layer_Loading(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			_percent = new TextField(200, 32, "0%");
			_percent.x = (parent.width - 300)/2;
			_percent.y = (parent.height - 32)/2;
			addChild(_percent);
		} 
		
		public function updatePercent(value:int) : void
		{
			var str:String = "玩命加载中(" + value.toString() + "%)...";
			_percent.text = str;
		}
	}
}