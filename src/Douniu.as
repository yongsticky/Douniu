package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import camu.design_pattern.Singleton;
	import camu.logger.Logger;
	
	import factory.NiuObjectFactory;
	
	import packet.game.message.WrapperMessage.WrapperMessageDecoder;
	import packet.game.tlv.UnionTLVDecoder;
	
	import resource.ResManager;
	
	import server.NiuServerConnection;
	
	import starling.core.Starling;
	
	import view.NiuDirector;
	
	[SWF(width="1120", height="800", frameRate="60", backgroundColor="#ffffff")]
	public class Douniu extends Sprite
	{
		
		private var _starling:Starling = null;
		
		public function Douniu()
		{
			stage ? initialize():addEventListener(Event.ADDED_TO_STAGE, function (event:Event) : void {
				event.target.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				initialize();
			});
		}
		
		
		private function initialize() : void
		{
			Logger.setOff(false);
			
			Singleton.init([new ResManager(), 
				new NiuObjectFactory(), 
				new NiuServerConnection(), 
				new WrapperMessageDecoder(), 
				new UnionTLVDecoder()]);	
			
			
			_starling = new Starling(NiuDirector, stage);
			_starling.start();
			
			_starling.showStats = true;
			_starling.antiAliasing = 2;
		}
	}
}