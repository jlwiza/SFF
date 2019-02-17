package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Vector3;

	public class FightScene extends MainScene
	{
		public function FightScene()
		{
			
			super();
		}
		
		// you basically override everything to get this into a fight scene its another programattically implemented scene, its just a cookie cutter to do steps that
		// will most likely be done over and over again in the gaming en
		
		override public function UpdateCamera(cam:MainStage = null, ctScene:String = null):void
		{
			msm.ProcessCameraMotion(cam);
		}
		
		// I made all these override public for the simple reason if I want some entity to turn the gravity or sonics jumps movement whatever on and off they can
		
		
		
		override public function UpdatePhysicsActor(hero:Vector3, actor:GeneralActor):void
		{
			msm.UpdatePhysicsActor(actor);
			
		}
		
		
		
		override public function ProcessCameraMotion(cam:MainStage):void
		{
			
			msm.ProcessCameraMotion(cam);
		}
		
		// makesur n update the walk and whatever
		
		// I think i can make it if i just keep sonic and the hero seperate i want this so i can have more dynamic movement
		// like hair flowing in the wind different from something else, but sonic should know what he's holding on to Ill put that on his motor, there
		
		// right now its fairly stupid and i just set it up as a small scene at the top of the hornets place, all it is I throw the badguy and then it tells me im awesome
		// plays an animation and we move on in a sequence where it then goes to the state that 
		
		public function ThrowFlyingBadGuy(hero:Hero, hornet:Hornet):void
		{
			
			// the code using the homing attact to throw the badguy
			// this has to be handled through the FSM considering all the cases where this could go wrong
			// then throw at target, target is always something 
		}
		
	}
}