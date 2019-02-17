package com.jonLwiza.engine.state.sonicBehavior.Ground
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class JumpCharge extends Behaviour
	{
		public function JumpCharge(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.triggerJumping && a.isGrounded)
			
		}
		
		override public function update():String
		{
			
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].jumpCharging != null)
					break;
			}
			
			status = actor.currScene[i].JumpCharge(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
		override public function exit(status:String):void
		{
			Hero(actor).calls = 0;
			
			Hero(actor).isJumping = true;
			
		}
		
	}
}