package com.jonLwiza.engine.state.sonicBehavior.Ground
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Skid extends Behaviour
	{
		public function Skid(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.skid && a.isGrounded && Math.abs(a.body.angularVel) >= a.walkSpeed)
		}
		
		override public function update():String
		{
			// this seems to go through the scenes and then it does the it goes through the chain where the scene has this being designed 
			actor.currMBehaviour = "Skid";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicSkid != null)
					break;
			}
			
			status = actor.currScene[i].SonicSkidding(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}