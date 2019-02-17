package com.jonLwiza.engine.actors
{
	import com.jonLwiza.engine.helperTypes.Vector3;

	public class BrokenHornet extends Hornet
	{
		private var greaterThan:Boolean;
		private var an:Number;
		private var moveBack:Boolean;
		private var ticker:int;
		private var origin:Vector3 = new Vector3();
		public function BrokenHornet()
		{
			//super();
		}
		
		override protected function wait():void
		{
			origin.X = hero.x;
			origin.Y = hero.y - 90;
			
			UpdateDistToSonic();
		
		
		if(hero.hitTestObject(this) && hero.key.Y == -1 && !hero.hanging)
		{
			isHeld = true;
			hero.hanging = true;
		}
		
		}
		override protected function attack():void
		{
			if(!started){
				if(x > hero.x)
					greaterThan = true;
				else
					greaterThan = false;
				justAttacked = true
				an = angleBtwnPts(new Vector3(x,y), origin);
				started = true;
				// if I so choose it may be a good idea to prepare my camera, so i can give it its end positions herr
			}
			
			x+= Math.cos(an)*20;
			if(greaterThan){
				if(x < hero.x){
					moveBack =true;
					attacking  = false;
					started = false;
					ticker = 0;
				
				}
			}else{
				
				if(x> hero.x){
					moveBack = true;
					started = false;
					//easeIn(this,testHAnim[backtoHomeAfterAttack][0],testHAnim[backtoHomeAfterAttack][1])
					attacking = false;
				}
			}
		// basically just lung towards him with some scripted animation that makes him look broken
			// its not as complex as the other one, cuz he's broken might wanna ease in to multiple spots I made a script for that, kinda
		}
		
		
	}
}