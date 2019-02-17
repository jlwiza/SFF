package
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.helperTypes.TMXParser;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var tmx:TMXParser = new TMXParser(); 
		private var hero:Hero = new Hero();
		private var main:Main = new Main();
		
		public function Game()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChild(main);
			// i should put the
//			var sonicPts:Array = tmx.objectSet("Hero");
//			//trace(hero.x, hero.y);
//			hero.x = sonicPts[0][0];
//			hero.y = sonicPts[0][1];
//			sonicPts = null;
//			//trace(hero.x, hero.y);
			
			
			
			
		}
	}
}