package com.jonLwiza.engine.Scenes.GeneralSceneAssets
{
	import com.jonLwiza.engine.Scenes.FightScene;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;

	// a better way to implement this is to make it so instead of this being a general it should point to the characters implementation of a fight
	// this just being sonics, basically im saying in the main function instead of calling this fightSceneMotor it should be sonic's Fight Scene Motor, and fightScene respectively
	public class FightSceneMotor extends MainSceneMotor
	{
		
		var target:GeneralActor = new target();
		
		private var fs:FightScene = new FightScene();
		
		public function FightSceneMotor()
		{
			
			super();
		}
		
		
		public function UpdateTarget(hero):void
		{
			
		}
		
		override protected function homingAttack(actor:GeneralActor, angle:Number, speed:Number)
		{
			// basically all this is it throws the object in a direction
			// so yeah just fires an object in a direction
		}
		
		public function ThrowFlyingBadGuy(hero:Hero)
		{
			
		// the code using the homing attact to throw the badguy
			// this has to be handled through the FSM considering all the cases where this could go wrong
			// then throw at target, target is always something 
		}
		
		
	}
}