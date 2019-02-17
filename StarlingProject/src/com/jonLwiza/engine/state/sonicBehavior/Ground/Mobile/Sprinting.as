package com.jonLwiza.engine.state.sonicBehavior.Ground.Mobile
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Sprinting extends Behaviour
	{
		public function Sprinting(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.isGrounded && Math.abs(a.body.angularVel) >= a.sprintSpeed &&!a.skid  && !a.triggerJumping)

		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Sprinting";
			for (var i:int = 0; i < actor.currScene.length -1; i++) 
			{
				
				if(actor.currScene[i].sonicSprinting != null)
					break;
			}
			
			status = actor.currScene[i].SonicSprinting(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}