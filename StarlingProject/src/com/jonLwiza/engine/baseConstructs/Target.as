package com.jonLwiza.engine.baseConstructs
{
	import nape.geom.Vec2;
	
	public class Target extends Baddie
	{
		
		public function Target()
		{
			super();
			blocking = true;
		}
		
		override public function Destroy():void
		{
			// play some dead animation, let sonic or gdyn pass you what the animation will be wait till completed then remove
			//handle the bounce and everything 
			//hero.gv.Y = -45;
			//trace("bleh......")
			if(!dead){
				
				
				// we implement a jumo to other points after this it'll also help control thing like hangtime
				
				//hero.moveVector.X = 25*hero.key.X;
				//var blast:MovieClip =  new MovieClip(Assets.getAtlas(atlas).getTextures("hornetExplosion"), 24);
				// i dont think its necessary but doesnt hurt
				dead = true;
			}
			
			//temp
			
		}
		
		
		
	}
}