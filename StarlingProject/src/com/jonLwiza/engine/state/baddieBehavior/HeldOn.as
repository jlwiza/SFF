package com.jonLwiza.engine.state.baddieBehavior
{
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.Baddie;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.baseConstructs.IState;
	import com.jonLwiza.engine.helperTypes.Status;
	
	public class HeldOn extends Behaviour 
	{
		
		// Good rule of thumb is never putting code in the behaviour places, because youll never find it
		// thats why it goes through and goes to main which you can later change
		public function HeldOn()
		{
			super()
		}
		
		override public function initialize():void
		{
			
			run = true//Baddie(actor).isHeld
			// instead of just saying running to jumping is a good transfer, it says well there is a bunch of spikes over me, so i should either say no i dont wanna, or transfer it
			// to a jumpdeath instead of just a regular jump
			
		}
		
		override public function update():String
		{
			
			status = actor.currScene[0].HeldOn(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status
		}
		
		override public function exit(status:String):void
		{
			//MainSceneMotor.mouseJoint.active = false;
		}
		
	}
}