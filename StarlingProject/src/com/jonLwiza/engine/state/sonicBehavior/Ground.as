package com.jonLwiza.engine.state.sonicBehavior
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.ControlledMobility;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Rolling;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Skid;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.Standing;
	import com.jonLwiza.engine.state.sonicBehavior.Ground.JumpCharge;
	
	public class Ground extends BehaviorSelector
	{
		private var cmobile:ControlledMobility = new ControlledMobility();
		private var rolling:Rolling = new Rolling();
		private var standing:Standing = new Standing();
		private var dState:DownState = new DownState();
		private var skid:Skid = new Skid();
		private var jCharge:JumpCharge = new JumpCharge();
		
		public function Ground(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [cmobile, rolling, standing, dState, skid, jCharge];
		}
		
		override public function TreeUpdate():String
		{
			// i dunno if i wrote this anywhere so im gonna write it here currScene[0] defaults to the mainone
			status = actor.currScene[0].SonicGround(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}