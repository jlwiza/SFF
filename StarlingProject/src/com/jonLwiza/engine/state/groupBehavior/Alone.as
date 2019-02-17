package com.jonLwiza.engine.state.groupBehavior
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.groupBehavior.alone.Idle;
	
	public class Alone extends BehaviorSelector
	{
		private var idle:Idle = new Idle();
		public function Alone(actor:GeneralActor=null)
		{
			super(actor);
			
			childNodes = [idle];
			
		}
	}
}