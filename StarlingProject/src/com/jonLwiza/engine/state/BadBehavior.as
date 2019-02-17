package com.jonLwiza.engine.state
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.baddieBehavior.Attacking;
	import com.jonLwiza.engine.state.baddieBehavior.HeldOn;
	import com.jonLwiza.engine.state.baddieBehavior.Throwing;
	import com.jonLwiza.engine.state.baddieBehavior.Waiting;
	import com.jonLwiza.engine.state.baddieBehavior.Dead;
	
	public class BadBehavior extends BehaviorSelector
	{
		private var wait:Waiting = new Waiting();
		private var held:HeldOn = new HeldOn();
		private var attacking:Attacking = new Attacking();
		private var thrown:Throwing = new Throwing();
		private var dead:Dead = new Dead();
		public function BadBehavior(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [wait, held, attacking, thrown, dead];
		}
		
		// tree update makes the whole tree act like a behavior so i can quickly jump out of it, I 
//		override public function TreeUpdate():String
//		{
//			// i dunno if i wrote this anywhere so im gonna write it here currScene[0] defaults to the mainone
//			
//			status = actor.currScene[0].BaddieBehavior(actor);
//			
//			// update returns a status anything besides invalid, invalid is just so init runs once
//			return status;
//		}
	}
}