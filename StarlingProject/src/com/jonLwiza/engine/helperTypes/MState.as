package com.jonLwiza.engine.helperTypes
{
	import com.jonLwiza.engine.baseConstructs.Behavior;
	import com.jonLwiza.engine.baseConstructs.IState;

	public class MState
	{
		private var _StateObj:Object;
		private var _From:Array = new Array();
		private var _To:String;
		protected var _name:String;
		public function MState(stateObj:Object, from:Array,to:String)
		{
			StateObj= stateObj;
			name = to;
			From = from;
			To = to;
		}

		

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get To():String
		{
			return _To;
		}

		public function set To(value:String):void
		{
			_To = value;
		}

		public function get From():Array
		{
			return _From;
		}

		public function set From(value:Array):void
		{
			_From = value;
		}

		public function get StateObj():IState
		{
			return _StateObj;
		}

		public function set StateObj(value:Object):void
		{
			_StateObj = value;
		}


	}
}