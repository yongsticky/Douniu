package view.framework
{	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class ExDirector extends ExSprite
	{			
		public function ExDirector()
		{	
			super();		
		}		

		override protected function initialize() : void
		{
			super.initialize();

			stage.addEventListener(Event.RESIZE, function(event:ResizeEvent):void {
				stage.stageWidth = event.width;
				stage.stageHeight = event.height;
				
				var topScene:ExScene = topScene;
				if (topScene) {
					topScene.onStageResize();
				}				
			});
		}
		
		override public function dispose() : void
		{
			super.dispose();
		}

		
		public function switchToScene(scene:ExScene) : void
		{			
			if (!scene)
			{
				return;
			}

			addChild(scene);
			
			setSceneFadeInOut(scene, 0, 1, 0.3, Transitions.EASE_IN, function () : void {
					while(numChildren > 1){removeChildren(0, numChildren-2);}					
				});	
			
		}
		
		public function pushScene(scene:ExScene) : void
		{
			if (!scene)
			{
				return;
			}

			setSceneFadeInOut(scene, 0, 1, 0.3, Transitions.EASE_IN);

			addChild(scene);		
		}
		
		public function popScene() : ExScene
		{
			var popScene:ExScene = topScene;

			if (numChildren > 1)
			{
				var newTopScene:ExScene = getChildAt(numChildren-2) as ExScene;
				if (newTopScene)
				{
					setSceneFadeInOut(popScene, 1, 0, 0.3, Transitions.EASE_IN, function() : void {
						swapChildrenAt(numChildren-1, numChildren-2);
						removeChildAt(numChildren-2, false);
						});
				}				
			}
			else
			{
				removeChildAt(numChildren-1, true);
			}

			return popScene;
		}
		
		public function get topScene() : ExScene
		{
			var scene:ExScene = getChildAt(this.numChildren-1) as ExScene;
			return scene;			
		}

		private function setSceneFadeInOut(scene:ExScene, alphaFrom:Number, alphaTo:Number, time:Number, transition:String = Transitions.LINEAR, completeHandler:Function = null) : void
		{
			scene.alpha = alphaFrom;

			var tn:Tween = new Tween(scene, time, transition);
			tn.fadeTo(alphaTo);
			
			Starling.juggler.add(tn);
			tn.onComplete = completeHandler;		
		}		
	}
}