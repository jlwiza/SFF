package com.jonLwiza.engine.state.sonicBehavior
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.sonicBehavior.Down.Ducking;
	import com.jonLwiza.engine.state.sonicBehavior.Down.SpinCharge;

	public class DownState extends BehaviorSelector
	{
		private var ducking:Ducking = new Ducking();
		private var spinCharge:SpinCharge = new SpinCharge();
		
		public function DownState(actor:GeneralActor=null)
		{
			childNodes = [ducking, spinCharge];
		}
	}
}