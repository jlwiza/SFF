package com.jonLwiza.engine.state.sonicBehavior.Air.Jump
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class JumpRising extends Behaviour
	{
		public function JumpRising(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (!a.hanging && !a.isGrounded && (a.isJumping|| a.triggerJumping) && a.body.velocity.y > 0)
			
		}
		
		
		override public function update():String
		{
			actor.currMBehaviour = "JumpRising";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicJumpRising != null)
					break;
			}
			
			status = actor.currScene[i].SonicJumpRising(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}