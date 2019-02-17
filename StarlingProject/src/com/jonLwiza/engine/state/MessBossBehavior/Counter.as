package com.jonLwiza.engine.state.MessBossBehavior
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.MessBossBehavior.Counter.Diving;
	import com.jonLwiza.engine.state.MessBossBehavior.Counter.Holding;
	import com.jonLwiza.engine.state.MessBossBehavior.Counter.Slapping;
	import com.jonLwiza.engine.state.MessBossBehavior.Counter.Throwing;
	
	public class Counter extends BehaviorSelector
	{
		private var diving:Diving = new Diving();
		private var holding:Holding = new Holding();
		private var throwing:Throwing = new Throwing();
		private var slapping:Slapping = new Slapping();
		public function Counter(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [diving, holding, throwing, slapping];
		}
	}
}