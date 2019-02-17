package com.jonLwiza.engine.state.baddieBehavior
{

	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Throwing extends Behaviour
	{
		public function Throwing()
		{
		 super();
		}
		
		
		override public function update():String
		{
			
			status = actor.currScene[0].Throwing(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}