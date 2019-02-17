package com.jonLwiza.engine.state.sonicBehavior.Down
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Status;
	
	public class SpinCharge extends Behaviour
	{
		private var behvaviorName:String = "SpinCharge"
		public function SpinCharge(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			if (actor.isGrounded && Hero(actor).spacebar && actor.body.angularVel < 2 && actor.key.Y > 0) 
			{
				run = true;
			Hero(actor).spinCharge = true;
			//Hero(actor).rolling = true;
			actor.stuck = true;
			actor.canJump = false
			}
		}
		
		override public function update():String
		{
			actor.currMBehaviour = behvaviorName;
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicCharging != null)
					break;
			}
			
			status = actor.currScene[i].SonicCharging(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
		override public function exit(status:String):void
		{
			if(Hero(actor).spinCharge){
			Hero(actor).spinCharge = false;
			actor.stuck = false;
			actor.canJump = true;
			Hero(actor).rolling = true;
				
			actor.moveVector.X = Hero(actor).charge*actor.dir;
			////trace("again?")
			}
		}
		
	}
}