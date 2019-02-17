package com.jonLwiza.engine.state.sonicBehavior.Ground
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Status;
	
	public class Rolling extends Behaviour
	{
		public function Rolling(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			if(actor.isGrounded && Math.abs(actor.body.angularVel) >= 2 && Hero(actor).key.Y >0){
			run= true;
				actor.attacking = true;
			Hero(actor).rolling = true;
			}
			
		}
		override public function update():String
		{
			
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				if(actor.currScene[i].sonicRolling != null)
					break;
			}
			// so this works that if none of them works it goes to main im guessing because itd be last on the stack i guess
			status = actor.currScene[i].SonicRolling(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		// i dont like exit
		override public function exit(status:String):void
		{
			// **needs fixing **/
			Hero(actor).attacking = false;
			Hero(actor).rolling = false;
			
		}
	}
}