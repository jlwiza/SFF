package com.jonLwiza.engine.state.MessBossBehavior
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class CrossSlash extends Behaviour
	{
		public function CrossSlash(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "CrossSlash";
			status = actor.currScene[0].MessCrossSlash(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}