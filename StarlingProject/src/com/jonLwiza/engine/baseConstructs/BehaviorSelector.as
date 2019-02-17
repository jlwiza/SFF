package com.jonLwiza.engine.baseConstructs
{
	import com.jonLwiza.engine.helperTypes.Status;

	public class BehaviorSelector extends Behaviour
	{
		private var _childNodes:Array = new Array();
		private var currentChild:Behaviour = new Behaviour();
		
		private var i:uint;
		
		// **needs fixing **/
		public function BehaviorSelector(actor:GeneralActor = null)
		{
		
			super(actor);
			readable = false;
			////trace("behavior actor", actor)
		}
		override public function initialize():void
		{
			run = true;
			i = 0;
			// instead of just saying running to jumping is a good transfer, it says well there is a bunch of spikes over me, so i should either say no i dont wanna, or transfer it
			// to a jumpdeath instead of just a regular jump
			
		}
		
		override public function update():String
		{
			status = TreeUpdate();
			if(status == Status.S_FAILURE)
			{
				//basically says if were doing something that kills the group like were in air commands, and were grounded dont bother going through each limb
				return Status.S_FAILURE;
			}
			// this while makes me uneasy
			while(true)
			{
				
				if(childNodes[i].actor == null)
					childNodes[i].actor = actor;
				
				status = childNodes[i].tick();
				
				
				
				if(status != Status.S_FAILURE)
				{
					return status;
				}
//				//trace("this is i:", i)
				// this may break if it goes out of the loop
				i++;
				if(i == childNodes.length)
				{
					// i = 0 is the only real deviation from the ai gamedev example
					//i = 0;
					return Status.S_FAILURE;
				}
				
			}
			
			
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return Status.S_INVALId
		}
		
		public function TreeUpdate():String
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		override public function exit(status:String):void
		{
			////trace("exit ", this, status);
		}
		
		public function get childNodes():Array
		{
			return _childNodes;
		}
		
		public function set childNodes(value:Array):void
		{
			_childNodes = value;
		}
	}
}