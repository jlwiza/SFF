package com.jonLwiza.engine.helperTypes
{
	public class Anim
	{
		private var _name:String;
		private var _loop:Boolean;
		private var _cutsIn:Boolean = false;
		private var _transFrame:Array = new Array();
		public function Anim(Animation:String, looping:Boolean = false)
		{
			
			name = Animation;
			loop = looping;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get loop():Boolean
		{
			return _loop;
		}

		public function set loop(value:Boolean):void
		{
			_loop = value;
		}

		public function get cutsIn():Boolean
		{
			return _cutsIn;
		}

		public function set cutsIn(value:Boolean):void
		{
			_cutsIn = value;
		}

		public function get transFrame():Array
		{
			return _transFrame;
		}

		public function set transFrame(value:Array):void
		{
			_transFrame = value;
		}


	}
}