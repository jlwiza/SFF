package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Vector3;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	
	public class AnimateStopWaitJump extends MainScene
	{
		private var on:Boolean = true;
		public function AnimateStopWaitJump()
		{
			
			super();
		}
		
		// basically this needs to be a sequence and its more aethtetic than anything
		// but you call  
		
		override public function Update(actor:Hero = null):void
		{
			if(!on)
				{
					// this is very lightly skeletoned in but its more fluff so ill do this later if at all, its important fluff though
			hero.key = new Vector3();
			msm.ProcessMotion(hero);
				}

			
			// i made this so I can just put some extra functionality without disturbing the mainScene set up aka I dont wanna have to keep rewriting this garbage, or whatever garbage I put here
			// but if i want i can start from scratch and use a different thing to process motion if i override this one, but just dont override it, unless all of a sudden i go into outerspace
			// or whatever
			//UpdateScene(actor);
		}
		
		override public function ground(hero:Vector3, actor:GeneralActor):void
		{
		
			msm.ground(hero,actor);
			if(actor.isGrounded)
			on = false;
		}
		
		override protected function HeroEntered():void
		{
			
			// needs sequence
			hero.playAnimation("waterJump")
		}
		
		
	}
}