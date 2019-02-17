package com.jonLwiza.engine.state.MessBossBehavior.Counter
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.actors.BaddieBoss;
	
	public class Diving extends Behaviour
	{
		
		public function Diving(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Diving";
			status = BaddieBoss(actor).BBossDiving(actor.currMBehaviour);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}