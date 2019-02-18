package
{
	import flash.display.NSprite;
	import flash.net.LocalConnection;
	import flash.utils.getDefinitionByName;
	
	
	
	public class coffee extends Sprite
	{
		public function coffee()
		{
			
			
			var conn:LocalConnection= new LocalConnection();
			
			conn.send("moduleServer", "ModuleUpdate");
		}
		/** when your passing in the main class name that you
		 * are currently trying to update it has to be on a
		 * a predetermined location or b the default package
		 * because i can't dynamically find out where it is
		 * .. well i can i just have to parse the string a bit
		 * I may wanna do that for orginazation sake later
		 * **/
		public function setScene(vx:String):*{
			// ideally to make this perfect i have to search if :: is in their to begin with then
			// do this
			
			var dname:String = vx.slice(vx.search("::")+2)
			
			var scnEdit:Class = getDefinitionByName(dname) as Class;

			
			return new scnEdit
			//var vx:* = tx;
			
			//return vx;
		}
	}
}