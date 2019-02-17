package com.jonLwiza.engine.state.MessBossBehavior.Counter
{
	import com.jonLwiza.engine.actors.BaddieBoss;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Slapping extends Behaviour
	{
		
		public function Slapping(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Slapping";
			status = BaddieBoss(actor).BBossSlapping(actor.currMBehaviour);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}