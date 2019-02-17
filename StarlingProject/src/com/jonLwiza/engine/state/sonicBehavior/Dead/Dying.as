package com.jonLwiza.engine.state.sonicBehavior.Dead
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Dying extends Behaviour
	{
		public function Dying(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		
		override public function update():String
		{
			actor.currMBehaviour = "Dying";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicdying != null)
					break;
			}
			
			status = actor.currScene[i].SonicDying(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
	}
}