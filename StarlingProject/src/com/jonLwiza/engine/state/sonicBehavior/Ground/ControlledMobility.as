package com.jonLwiza.engine.state.sonicBehavior.Ground
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Mobile.Jogging;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Mobile.Running;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Mobile.Sprinting;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Mobile.Walking;
	
	public class ControlledMobility extends BehaviorSelector
	{
		private var walking:Walking = new Walking();
		private var jogging:Jogging = new Jogging();
		private var running:Running =  new Running();
		private var sprinting:Sprinting = new Sprinting();
		
		
		public function ControlledMobility(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [walking, jogging, running, sprinting];
		
		}
	}
}