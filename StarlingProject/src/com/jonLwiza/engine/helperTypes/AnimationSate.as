package com.jonLwiza.engine.helperTypes
{
	import com.jonLwiza.engine.baseConstructs.IState;

	public class AnimationSate extends MState
	{
		private var _StateObj:IState
		private var _From:Array = new Array();
		private var _To:Anim;
		public function AnimationSate(stateObj:IState, from:Array,to:Anim)
		{
			StateObj= stateObj;
			From = from;
			To = to;
		}

		


		public function get From():Array
		{
			return _From;
		}

		public function set From(value:Array):void
		{
			_From = value;
		}

		public function get To():Anim
		{
			return _To;
		}

		public function set To(value:Anim):void
		{
			_To = value;
		}


	}
}