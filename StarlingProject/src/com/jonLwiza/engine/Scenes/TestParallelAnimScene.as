package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Status;
	
	public class TestParallelAnimScene extends MainScene
	{
		
		private var frameTicker:int = 0;
		private var tweenTos:Array = [["ParallelrunningTOParallelsprinting",12,23],["jumpFallingTOParallelsprinting",12,23]];
		private var qframeTicker:Number;
		private var startTicker:Boolean =  false;
		
		public function TestParallelAnimScene()
		{
			super();
		}
		
		override protected function addedToStage():void
		{
			
		}
		
		override protected function HeroEntered():void
		{
			hero.parallelTweeens = tweenTos
			startTicker = true;
			
		
		}
		
		
		override public function Update(actor:Hero = null):void
		{
			// this is test and is subject to failure it basis its values on 60/24 = 2.5
			if (startTicker) 
			{
			qframeTicker++;
			if(qframeTicker%3 == 0)
			{frameTicker =qframeTicker/3}
			
			}
			
		}
		
		
		override public function SonicRunning(actor:GeneralActor):String
		{
			if(hero.isGrounded && Math.abs(hero.body.angularVel) >= hero.runSpeed && Math.abs(hero.body.angularVel) < hero.sprintSpeed && hero.key.Y <= 0 && !hero.rolling&&!hero.skid && !hero.triggerJumping)
			{
				Animateto("",false,frameTicker)
				return Status.S_RUNNING//AnimationStateUpdate(ani, false, true);
			}
			else{
				return Status.S_FAILURE
			}
		}
		
		override public function SonicSprinting(actor:GeneralActor):String
		{
			if(hero.isGrounded && Math.abs(hero.body.angularVel) >= hero.sprintSpeed && !hero.skid && !hero.triggerJumping)
			{
				Animateto("",false,frameTicker)
				return Status.S_RUNNING//AnimationStateUpdate(ani, false, true);
			}
			else{
				return Status.S_FAILURE
			}
		}
		
	}
}