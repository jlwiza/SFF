package com.jonLwiza.engine.state.sonicBehavior.Ground.Mobile
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Running extends Behaviour
	{
		public function Running(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.isGrounded && Math.abs(a.body.angularVel) >= a.runSpeed && Math.abs(a.body.angularVel) < a.sprintSpeed && a.key.Y <= 0 &&!a.rolling &&!a.skid  && !a.triggerJumping)

		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Running";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicRunning != null)
					break;
			}
			
			status = actor.currScene[i].SonicRunning(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}