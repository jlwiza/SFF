package com.jonLwiza.engine.state.sonicBehavior.Air
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.sonicBehavior.Air.Jump.JumpFalling;
	import com.jonLwiza.engine.state.sonicBehavior.Air.Jump.JumpRising;
	
	public class Jumping extends BehaviorSelector
	{
		private var jumpFalling:JumpFalling = new JumpFalling();
		private var jumpRising:JumpRising = new JumpRising();
		public function Jumping(actor:GeneralActor=null, name:String=null)
		{
			super(actor);
			childNodes = [jumpFalling, jumpRising];
		}
		
		
		
	}
}