package com.jonLwiza.engine.state.sonicBehavior.Ground.Mobile
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Jogging extends Behaviour
	{
		public function Jogging(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.isGrounded && Math.abs(a.body.angularVel) >= a.jogSpeed && Math.abs(a.body.angularVel) < a.runSpeed && a.key.Y <= 0 &&!a.rolling &&!a.skid  && !a.triggerJumping)

		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Jogging";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicJogging != null)
					break;
			}
			
			status = actor.currScene[i].SonicJogging(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}