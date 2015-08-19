
package resource
{
	import flash.events.Event;

	public class ResLoaderEvent extends Event
	{
		public static const COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		public static const FAILED:String = "failed";

		public function ResLoaderEvent(name:String)
		{
			super(name);
		}
	}	
}
