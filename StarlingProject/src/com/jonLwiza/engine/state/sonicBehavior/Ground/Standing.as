package com.jonLwiza.engine.state.sonicBehavior.Ground
{

	
	import com.jonLwiza.engine.baseConstructs.BehaviorSequence;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Standing.Idle;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Standing.Pissed;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Standing.Waiting;
	
	public class Standing extends BehaviorSequence
	{
		private var idle:Idle = new Idle();
		private var waiting:Waiting = new Waiting();
		private var pissed:Pissed = new Pissed();
		
		public function Standing(actor:GeneralActor=null, name:String=null)
		{
			super(actor);
			
			childNodes = [waiting, idle,pissed];
		}
		
		
		
	}
}