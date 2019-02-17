package com.jonLwiza.engine.helperTypes
{
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	import starling.events.Event;
	
	public class LevelEvent extends Event
	{
		// its basically pretty easy you just extend event dispatch an event wgere you want it to dispact with the extended event object and add an eventlistener wherever needed
		private var _actor:GeneralActor
		public function LevelEvent(type:String, actor:GeneralActor)
		{
			super(type);
			this.actor = actor;
		}

		public function get actor():GeneralActor
		{
			return _actor;
		}

		public function set actor(value:GeneralActor):void
		{
			_actor = value;
		}

	}
}