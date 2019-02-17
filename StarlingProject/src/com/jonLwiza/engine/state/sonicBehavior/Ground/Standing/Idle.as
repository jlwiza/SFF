package com.jonLwiza.engine.state.sonicBehavior.Ground.Standing
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Idle extends Behaviour
	{
		public function Idle(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.isGrounded && Math.abs(a.body.angularVel) < 0.4 && a.key.Y <= 0 && !a.triggerJumping)
		}
		
		override public function update():String
		{
			
			actor.currMBehaviour = "Idle";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicIdle != null)
					break;
			}
			
			status = actor.currScene[i].SonicIdle(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}