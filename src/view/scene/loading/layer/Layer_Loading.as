package view.scene.loading.layer
{
	import starling.text.TextField;
	
	import view.framework.ExLayer;
	import view.scene.loading.cell.Progress;
	
	public class Layer_Loading extends ExLayer
	{	
		private var _progress:Progress;		
		private var _tip:TextField;		
		
		public function Layer_Loading(name:String=null)
		{
			super(name);
		}
		
		override protected function createChildren() : void
		{
			_progress = new Progress();
			addChild(_progress);
			
			_tip = new TextField(600, 32, "如果长时间无法加载或进入游戏，请尝试CTRL+F5刷新，或清空浏览器缓存后再次登录。");
			_tip.fontName = "Microsoft YaHei";
			_tip.fontSize = 14;
			addChild(_tip);			
		} 
		
		
		override protected function layoutChildren():void
		{	
			_progress.x = (stage.stageWidth - _progress.width) / 2;
			_progress.y = stage.stageHeight - _progress.height - 140;
			
			_tip.x = (stage.stageWidth-_tip.width)/2;
			_tip.y = stage.stageHeight - _tip.height - 40;	
			
			
			super.layoutChildren();
		}
		
		public function updatePercent(value:int) : void
		{			
			_progress.updatePercent(value);
		}
	}
}