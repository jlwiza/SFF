package
{
	public class CliffScene
	{
		public function CliffScene()
		{
		}
		
		public function UpdateScene(actor:*,ths:*):void
		{
			//trace("FDS ee", actor.body.position.x)
			actor.body.position.x = 42218
			
			//			if(i >= 720)
			//			throw Error("HurrayX2!!");
		}
		
		public function defaultUpdateScene(actor:*,ths:*):void
		{
			
			//trace("NEW THINGY", actor.x)
			//throw Error("some craps")
			// play the splash scenary the name of which
			
			
			
		}
		
		public function addedToStage():void
		{
			
		}
		public function HeroEntered(ths:*):void
		{
			
		}
		
		public function defaultHeroEntered(ths:*):void
		{
			// in this one its easy to pass references between
			// a child box and its parents but if i had a 
			// independent one for some reason i cant think of
			// i simply put the refence on this, which would mean
			// saving it and putting it and restarting the program
			
			
//			for (var i:int = 0; i < ths.stage_mc.scenary.length; i++) 
//			{
//				if(ths.stage_mc.scnes[i].movie.name == "theScene"){
//					var theScene:* = ths.stage_mc.scnes[i]
//					break
//				}
//			}
//			// or something 
//			ths.stage_mc.scenary[i].alpha = 1;
//			ths.stage_mc.scenary[i].movie.play()
			// and do the same for the other one 
			// but match its x and y, also i may wanna slow
			// it for a second but its all pretty fucking easy
			
		}
		
		public function HeroLeft():void
		{
			
		}
	}
}