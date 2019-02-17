package com.jonLwiza.engine.baseConstructs
{
	import com.jonLwiza.engine.helperTypes.Status;
	
	import flash.utils.getQualifiedClassName;

	public class Behaviour
	{
		protected var _actor:GeneralActor;
		protected var readable:Boolean = true;
		protected var run:Boolean = false;
		//all status is like an observer to see whats going on here, its pretty useless for sonic, except if maybe his animation gets cut off, but for the ai this is central
		private var _status:String = Status.S_INVALId;
		private var  _name:String;
		// **needs fixing **/
		// when you call a behavior you send an actor through so your class can know bout it
		public function Behaviour(actor:GeneralActor = null, name:String = null)
		{
			this.actor = actor;
			var vx:String = getQualifiedClassName(this)
			var dname:String = vx.slice(vx.search("::")+2)
			this.name = dname;
//			//trace("the behavior",actor);
		}
		
		
		public function tick():String
		{
			
			
			if(status != Status.S_RUNNING)
				{
				////trace(actor);
				// i dunno what the fuck this is
					initialize();
					
					actor.lineage.unshift(name);
				}
			//this run stuff only works with behavior selector
			if(run){
			status = update();
			if(!(this is BehaviorSelector))
			actor.currMBehaviour = this.name
			if(readable){
			if(status == Status.S_RUNNING)
			actor.currentStatus = this;
			}
			
			////trace(this, actor);
			if(status != Status.S_RUNNING)
			{
				
				// it tells me wether or not this behavior failed or not because it wont ever be invalid unless there is an erroror its an invalid state
				// right your not supposed to change anything on the exit status it more just tells things how stuff is, because you have to imagine that all the exit statuses are being ran
				exit(status);
				// i put the if conditional simply because i wanted to check if its ever null on frames, it would help in debugging
				if(actor.currentStatus != null){
				actor.lastStatus = actor.currentStatus;
				actor.currentStatus = null;
				}
				// if this is flawed itll suck
				// they all need unique names which Ive yet to do
				actor.lineage.splice(this,1);
				
			}
			}else{
				status = Status.S_FAILURE
			}
			return status
		}
		
		public function initialize():void
		{
			// may unmake the world!!!
			run = true
			
			// instead of just saying running to jumping is a good transfer, it says well there is a bunch of spikes over me, so i should either say no i dont wanna, or transfer it
			// to a jumpdeath instead of just a regular jump
			
		}
		
		public function up():String
		{
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status
		}
		
		public function update():String
		{
		
			// update returns a status anything besides invalid, invalid is just so init runs once
			return status
		}
		
		public function exit(status:String):void
		{
			
		}

		public function get actor():GeneralActor
		{
			return _actor;
		}

		public function set actor(value:GeneralActor):void
		{
			_actor = value;
		}

		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}


	}
}