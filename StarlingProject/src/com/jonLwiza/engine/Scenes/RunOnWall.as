package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Vector3;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;

	public class RunOnWall extends MainScene
	{
		public function RunOnWall()
		{
			
			super();
			sonicRunning = "sidewaysrunloop";
			sonicJogging ="sidewaysrunloop";
			sonicSprinting ="sidewaysrunloop";
		}
		
		
		
		override protected function HeroEntered():void
		{
			// needs sequence
			//hero.playAnimation("jumpOnWall")
		}
		
		override public function ground(hero:Vector3, actor:GeneralActor):void
		{
			if(actor.moveVector.X >= 12)
			msm.ground(hero, actor);
			
			
			
		}
		
		
	}
}