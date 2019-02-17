package com.jonLwiza.engine.state.MessBossBehavior
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class DownSlash extends Behaviour
	{
		public function DownSlash(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function update():String
		{
			actor.currMBehaviour = "DownSlash";
			status = actor.currScene[0].MessDownSlash(actor);
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}