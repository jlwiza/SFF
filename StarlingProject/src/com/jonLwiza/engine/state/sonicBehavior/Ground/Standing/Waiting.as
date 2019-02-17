package com.jonLwiza.engine.state.sonicBehavior.Ground.Standing
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Waiting extends Behaviour
	{
		public function Waiting(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		
		override public function initialize():void
		{
			
			var a:Hero = actor as Hero
			run = (a.isGrounded && Math.abs(a.body.angularVel) < 2 && !a.triggerJumping)	
			
			
		}
		
		
		
		override public function update():String
		{
			
			actor.currMBehaviour = "Waiting";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicwaiting != null)
					break;
			}
			
			status = actor.currScene[i].SonicWaiting(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
		
		
	}
}