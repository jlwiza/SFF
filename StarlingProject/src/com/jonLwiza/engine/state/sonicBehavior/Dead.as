package com.jonLwiza.engine.state.sonicBehavior
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.sonicBehavior.Dead.Dead;
	import com.jonLwiza.engine.state.sonicBehavior.Dead.Dying;
	
	public class Dead extends BehaviorSelector
	{
		private var dead:com.jonLwiza.engine.state.sonicBehavior.Dead.Dead= new com.jonLwiza.engine.state.sonicBehavior.Dead.Dead();
		private var dying:Dying = new Dying()
		public function Dead(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [dead, dying];
		}
	}
}