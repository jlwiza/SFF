package com.jonLwiza.engine.state.groupBehavior.alone
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Idle extends Behaviour
	{
		public function Idle(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Idle";
			status = actor.currScene[0].MessIdle(actor);
			// update returns a status0 anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}