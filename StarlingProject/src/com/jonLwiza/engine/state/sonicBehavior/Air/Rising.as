package com.jonLwiza.engine.state.sonicBehavior.Air
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Rising extends Behaviour
	{
		public function Rising(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (!a.hanging && !a.isGrounded && !a.isJumping && !a.triggerJumping && a.body.velocity.y > 0)

		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Rising";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicRising != null)
					break;
			}
			
			status = actor.currScene[i].SonicRising(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}