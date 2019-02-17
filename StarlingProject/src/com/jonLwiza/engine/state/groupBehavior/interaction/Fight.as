package com.jonLwiza.engine.state.groupBehavior.interaction
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;

	
	
	public class Fight extends Behaviour
	{
		public function Fight(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Fight";
			status = actor.currScene[0].groupFight(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}