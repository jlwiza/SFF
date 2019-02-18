package 
{
	import com.jonLwiza.engine.Main;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	


	public final class Connection
	{
		public static var module:*
		private var _coolDown:int

		private var img1Loader:Loader;

		public static var conn:LocalConnection;
		public function Connection()
		{
			
			conn = new LocalConnection();
			conn.client = this
			conn.allowDomain("*")
			conn.connect("_moduleServer");
		}
		
		public function moduleUpdate():void{
			throw Error("connection Established")
			// okay the cooldown is so that it isnt caught in an endless loop
			if(coolDown == 0){
				var fl:File = new File(File.userDirectory.nativePath+"/Google Drive/Module/src/Module.swf")
				var img1Request:URLRequest = new URLRequest(fl.url);
				img1Loader = new Loader();
				img1Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
				//img1Loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, complete);
				img1Loader.load(img1Request);
				
				coolDown = 30
			}
		}
		
		protected function complete(event:Event):void
		{
			//trace("update complete")
			module = img1Loader.content
			// go through and find all the modules in the scene
			// update set their modules, and check if they
			// want to use the live version
				// actually just take the scene sonic is in
				// you dont use multiple scenes to control
				// everything, scenes alter sonics behaviour
				// in some shape or form if not its just an assets
				// actor or scenary, this way they can still be updated
				// without being wasteful
			Main.liveCamera.hero_mc.currScene[0].setModule()
				throw Error("What What")
		}
		
		public function update():void
		{
			if(coolDown> 0)
				coolDown --;
		}

		public function get coolDown():int
		{
			return _coolDown;
		}

		public function set coolDown(value:int):void
		{
			_coolDown = value;
		}

	}
}