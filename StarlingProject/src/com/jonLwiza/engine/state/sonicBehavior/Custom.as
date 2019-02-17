package com.jonLwiza.engine.state.sonicBehavior
{
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class Custom extends Behaviour
	{
		public function Custom(actor:GeneralActor=null, name:String=null)
		{
			super(actor, name);
		}
		
		override public function initialize():void
		{
			var a:Hero = actor as Hero
			run = (a.customState)
			
		}
		
		
		override public function update():String
		{
			actor.currMBehaviour = "Custom";
			for (var i:int = 0; i < actor.currScene.length-1; i++) 
			{
				
				if(actor.currScene[i].sonicFalling != null)
					break;
			}
			
			status = actor.currScene[i].SonicCustom(actor);
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status;
		}
		
	}
}