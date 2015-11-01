package view.scene.hall.cell
{	
	import starling.display.Button;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class RoomItem extends Button
	{
		private var _roomId:int;
		
		private var _roomNameTextFontFace:String = "";
		private var _roomNameTextFontSize:int = 20;
		private var _roomNameTextFontColor:uint = 0xFF8000;
		
		private var _roomDescTextFontFace:String = "";
		private var _roomDescTextFontSize:int = 14;
		private var _roomDescTextFontColor:uint = 0x308014;
		
		public function RoomItem(upState:Texture=null, text:String="", downState:Texture=null, overState:Texture=null, disabledState:Texture=null)
		{		
			super(upState, text, downState, overState, disabledState);
		}	
		
		public function set roomNameTextFontFace(value:String) : void
		{
			_roomNameTextFontFace = value;
		}
		
		public function set roomNameTextFontSize(value:int) : void
		{
			_roomNameTextFontSize = value;
		}
		
		public function set roomNameTextFontColor(value:uint) : void
		{
			_roomNameTextFontColor = value;
		}
		
		public function set roomName(value:String) : void
		{
			var nameTF:TextField = new TextField(width, 28, value, _roomNameTextFontFace, _roomNameTextFontSize, _roomNameTextFontColor); 			
			nameTF.vAlign = VAlign.CENTER;
			nameTF.hAlign = HAlign.CENTER;
			nameTF.y = 10;
			addChild(nameTF);
		}
		
		public function set roomDescTextFontFace(value:String) : void
		{
			_roomDescTextFontFace = value;
		}
		
		public function set roomDescTextFontSize(value:int) : void
		{
			_roomDescTextFontSize = value;
		}
		
		public function set roomDescTextFontColor(value:uint) : void
		{
			_roomDescTextFontColor = value;
		}
		
		public function set roomDesc(value:String) : void
		{
			var descTF:TextField = new TextField(width, 28, value, _roomDescTextFontFace, _roomDescTextFontSize, _roomDescTextFontColor);		
			descTF.vAlign = VAlign.CENTER;
			descTF.hAlign = HAlign.LEFT;
			descTF.x = 30;
			descTF.y = 100;			
			addChild(descTF);
		}
		
		public function set roomId(value:int) : void
		{
			_roomId = value;
		}
		
		public function get roomId() : int
		{
			return _roomId;
		}
	}
}