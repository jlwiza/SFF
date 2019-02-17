package com.jonLwiza.engine.baseConstructs
{
	import starling.display.Sprite;
	import com.jonLwiza.engine.helperTypes.SND;
	
	public class GeneralSound extends SoundHandler
	{
		private var _soundState:String;
		public function GeneralSound()
		{
			super();
		}
		
		//
		public function SoundStateUpdate(sound:SND, state:String):void
		{
			playSound(sound)
			// translate sound
			soundState = state;
			
		}
		
		
		
		public function get soundState():String
		{
			return _soundState;
		}
		
		public function set soundState(value:String):void
		{
			_soundState = value;
		}
	}
}