package com.jonLwiza.engine.state.MessBossBehavior.Counter
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.actors.BaddieBoss;
	
	public class Throwing extends Behaviour
	{

		public function Throwing(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Throwing";
			status = BaddieBoss(actor).BBossThrowing(actor.currMBehaviour);
			return status;
		}
		
		
		
	}
}