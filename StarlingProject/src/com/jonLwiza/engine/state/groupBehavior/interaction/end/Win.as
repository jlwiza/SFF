package com.jonLwiza.engine.state.groupBehavior.interaction.end
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Win extends Behaviour
	{
		public function Win(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "Win";
			status = actor.currScene[0].GroupSonicWin(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}