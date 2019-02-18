package 
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.DisplayListWatcher;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksDesktopTheme;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class FeatherMain extends Sprite
	{
		//Screens
		//** THIS IS LIKE THE ANIMATION WINDOW
		private static const X_SHEET:String = "xsheet"
		//**THIS IS WHERE YOU CAN EDIT ADDD NEW ITEMS AND THE LIBRARY
		private static const MAIN_EDIT:String ="mainEditor" 
		public static var nav:ScreenNavigator;
		private static var _instance :FeatherMain;
		private var keyHandler:EditKeyHandler = new EditKeyHandler();
		
		public static function getInstance():FeatherMain
		{
			return _instance;
		}
		
		public function FeatherMain()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init(e:Event):void
		{
			
			var theme:MetalWorksDesktopTheme = new MetalWorksDesktopTheme()
			addChild(keyHandler);
			nav = new ScreenNavigator();
			addChild(nav);
			
			var mEdit:ScreenNavigatorItem = new ScreenNavigatorItem(mainEdit, {listSelected: selected}, null);
			nav.addScreen(MAIN_EDIT, mEdit);
			
			nav.showScreen(MAIN_EDIT);
			var xsht:ScreenNavigatorItem = new ScreenNavigatorItem(xSheet, {complete: ImageSelected}, null);
			nav.addScreen(X_SHEET, xsht);
			
			
		}
		
		private function ImageSelected(e:Event, si:Object):void
		{
		}
		
		private function selected(e:Event, si:Object):void
		{
			
		}
	
	}
}