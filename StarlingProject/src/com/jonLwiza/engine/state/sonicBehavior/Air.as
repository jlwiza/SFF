package com.jonLwiza.engine.state.sonicBehavior
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.sonicBehavior.Air.Falling;
	import com.jonLwiza.engine.state.sonicBehavior.Air.Jumping;
	import com.jonLwiza.engine.state.sonicBehavior.Air.Rising;
	
	public class Air extends BehaviorSelector
	{
		private var jumping:Jumping = new Jumping();
		private var falling:Falling = new Falling();
		private var rising:Rising = new Rising();
		public function Air(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [falling,jumping,rising];
			
		}
		
	}
}