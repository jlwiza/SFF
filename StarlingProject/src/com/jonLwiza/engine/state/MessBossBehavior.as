package com.jonLwiza.engine.state
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.MessBossBehavior.Counter;
	import com.jonLwiza.engine.state.baddieBehavior.Attacking;
	import com.jonLwiza.engine.state.baddieBehavior.Waiting;
	
	public class MessBossBehavior extends BehaviorSelector
	{// the cool thing about this system is that you can take and create a new set of behavior
	 // by taking ones that it subclassed from and putting them here, and even behaviors that it isnt related too
	// in other words you can make sonic perform a behavior through this class
		// or even a set of different bunch of behaviors
		//private var downSlash:DownSlash = new DownSlash();
		//private var movement:Movement = new Movement();
		//private var crossSlash:CrossSlash = new CrossSlash();
		private var waiting:Waiting = new Waiting();
		private var counter:Counter = new Counter();
		private var attacking:Attacking = new Attacking();
		public function MessBossBehavior(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [waiting,attacking, counter];
		}
	}
}