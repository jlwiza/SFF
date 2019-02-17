package com.jonLwiza.engine.helperTypes
{
	import com.jonLwiza.engine.baseConstructs.IState;

	public class SoundSate extends MState
	{
		private var _StateObj:IState
		private var _name:String;
		private var _From:Array = new Array();
		private var _To:SND;
		public function SoundSate(stateObj:IState, from:Array,to:SND)
		{
			StateObj= stateObj;
			name = to.name;
			From = Array;
			To = SND;
			
		}

		


		public function get From():Array
		{
			return _From;
		}

		public function set From(value:Array):void
		{
			_From = value;
		}

		public function get To():SND
		{
			return _To;
		}

		public function set To(value:SND):void
		{
			_To = value;
		}


	}
}