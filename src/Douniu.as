package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	import camu.singleton.Singleton;
	import camu.logger.Logger;
	
	import factory.NiuObjectFactory;		
	import packet.game.message.Notify.TGameEventDecoder;
	import packet.game.message.WrapperMessage.WrapperMessageDecoder;
	import packet.game.tlv.UnionTLVDecoder;	
	import resource.ResManager;	
	import server.NiuServerConnector;
	import server.NiuServerRequestSender;
	import server.NiuServerResponseReceiver;	
	import view.NiuDirector;
	
	[SWF(width="1120", height="640", frameRate="60", backgroundColor="#ffffff")]
	//[SWF(width="640", height="480", frameRate="60", backgroundColor="#ffffff")]
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
				new NiuServerConnector(), 
				new WrapperMessageDecoder(), 
				new UnionTLVDecoder(),
				new TGameEventDecoder(),
				new NiuServerResponseReceiver(),
				new NiuServerRequestSender()]);	
			
			
			_starling = new Starling(NiuDirector, stage);
			_starling.start();
			
			_starling.showStats = true;
			_starling.antiAliasing = 2;
		}
	}
}