package com.jonLwiza.engine.state.sonicBehavior.Down
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Ducking extends Behaviour
	{
		public function Ducking(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.isGrounded && Math.abs(a.body.angularVel) < 2 && a.key.Y >0 && !a.spacebar)
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Ducking";
			// this is literally insane i dont understand what i was thinking
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicDucking != null)
					break;
			}
			
			status = actor.currScene[i].SonicDucking(actor);
		
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
		override public function exit(status:String):void
		{
			actor.stuck = false;
			actor.canJump = true;
		}
	}
}