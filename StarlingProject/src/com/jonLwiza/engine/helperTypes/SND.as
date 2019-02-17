package com.jonLwiza.engine.helperTypes
{
	public class SND
	{
		private var _name:String;
		private var _loop:int;
		private var _FadeIn:Boolean;
		private var _FadeOut:Boolean;
		private var _cutsIn:Boolean;
		
		//looping is -1 for no looping 0 for infinite and numbers for how many times it plays
		public var vol:Number;
		
		public function SND(sound:String, looping:int = -1, fadeIn:Boolean =false, fadeOut:Boolean = false)
		{
			name = sound;
			loop = looping;
			FadeIn = fadeIn;
			FadeOut = fadeOut;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get loop():int
		{
			return _loop;
		}

		public function set loop(value:int):void
		{
			_loop = value;
		}

		public function get FadeOut():Boolean
		{
			return _FadeOut;
		}

		public function set FadeOut(value:Boolean):void
		{
			_FadeOut = value;
		}

		public function get FadeIn():Boolean
		{
			return _FadeIn;
		}

		public function set FadeIn(value:Boolean):void
		{
			_FadeIn = value;
		}

		public function get cutsIn():Boolean
		{
			return _cutsIn;
		}

		public function set cutsIn(value:Boolean):void
		{
			_cutsIn = value;
		}


	}
}