package global
{
	import flash.events.Event;
	
	public class UserSettingsEvent extends Event
	{
		public static const CHANGED:String = "changed";	
		
		private var _changedId:int;
		private var _changedValue:*;
		
		public function UserSettingsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		public function get changedId() : int
		{
			return _changedId;
		}
		
		internal function set changedId_(value:int) : void
		{
			_changedId = value;
		}
		
		public function get changedValue() : *
		{
			return _changedValue;
		}
		
		internal function set changedValue_(value:*) : void
		{
			_changedValue = value;
		}
	}
}