package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	import starling.display.Sprite;
	
	public class DynamicBlock extends Sprite
	{
		private var hero:Hero = new Hero();
		
		// I wanna put this both stoping sonic so he pushes on it, also let this be subclassed so it can have more functionality so that i can make it an immovable block or mobile
		// and since he'll never push more than 4 blocks at the same time directly i need to handle that, I dont like putting real physics too much ends up having a ragdoll feel
		// remember this is a bit harder than it seems first do an update to check whether sonics distance is within the screen then we'll test and do fancy stuff
		private var projectile:GeneralActor = new GeneralActor();
		private var _leftRight:Boolean = true;
		public function DynamicBlock()
		{
			super();
		}
		
		// were gonna do it real simple at first were just gonna watch sonics position track it and see how close he is, if he's too close we push him back
		// also all of em will actually change so that its me passing sonic to it to the update
		
		public  function Update(s:Hero):void
		{
			hero = s;
			
			// this needs to be change to account for rotation but for now
			// im gonna just use a regular hitTest but this needs to be smarter in the future so shit doesnt get slow easily
//			if((hero.hitTestObject(this))
//			{
//				hero.x > x && hero.y > y && hero.x < x+width && hero.y < y+height
//				// i need to add a function that overrrides the hero's junk otherwise i feel like im accounting for too many states, I dont think im using behaviour trees correctly
//				
//			}
			// its actually a more complicated then it seems, we have to check what its last position was draw a line between the last position and its corrent position and push pixel by pixel sonic back till he gets to where he is, because sonic is very fast and its the only way we can acount for his speed because he could literally run right through a hit zone but for now
			// very temporary this should be
			if(x!=-999999 && leftRight)
			DoStuff()
			else{
				DoOtherstuff();
			}
			
			
			
		}
		
		private function DoOtherstuff():void
		{
			if(hero.x > x && hero.x<x+width && hero.y > y && hero.y < y+height)
			{
				
				if(hero.y< y + height/2)
				{
					hero.gv.Y = 0
					hero.y = y
				}else if(hero.x> x + height/2){
					hero.moveVector.X = 0
					hero.y = y+height+hero.height;
				}
				
			}
		}
		
		private function DoStuff():void
		{
			if(hero.x > x && hero.x<x+width && hero.y > y && hero.y < y+height)
			{
				
				if(hero.x< x + width/2)
				{
					hero.moveVector.X = 0
					hero.x = x
				}else if(hero.x> x + width/2){
					hero.moveVector.X = 0
					hero.x = x+width+hero.width
				}
				
			}
			
			if(hero.heldOnTo){
				projectile = hero.heldOnTo
			}
			
			if(projectile)
			{
				if(projectile.hitTestObject(this)){
					//					this = null
					//					this.parent.removeChild(this);
					this.x = -999999
					this.y = -99999
				}
				
			}
			
		}		

		public function get leftRight():Boolean
		{
			return _leftRight;
		}

		public function set leftRight(value:Boolean):void
		{
			_leftRight = value;
		}

		
	}
}