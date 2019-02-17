package com.jonLwiza.engine.state.groupBehavior.interaction
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Spot extends Behaviour
	{
		public function Spot(actor:GeneralActor=null, name:String=null)
		{
		
		super(actor,name);
		
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Spot";
			status = actor.currScene[0].GroupSpot(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}