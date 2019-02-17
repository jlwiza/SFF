package com.jonLwiza.engine.state.MessBossBehavior.Counter
{
	import com.jonLwiza.engine.actors.BaddieBoss;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Holding extends Behaviour
	{
	
		public function Holding(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			// incase this gets confusing i directly accessed the bboss instead of going through the scene cuz the boss is specific to this point and is never slightly altered
			actor.currMBehaviour = "Holding";
			status = BaddieBoss(actor).BBossHolding(actor.currMBehaviour);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}