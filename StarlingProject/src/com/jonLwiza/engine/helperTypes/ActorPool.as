package com.jonLwiza.engine.helperTypes
{
	import starling.display.DisplayObject;

	public class ActorPool
	{
		public static var pool:Array;
		private static var counter:int;
		
		public function ActorPool()
		{
			
		}
		// just uh check its type and you should be good
		public static function init(type:Class, len:int):void
		{
			pool = new Array();
			counter = len;
			
			var i:int = len;
//			while(--i > -1)
//				pool[i] = new type();
		}
		
		public static function getSprite():DisplayObject
		{
			if(counter > 0){
				
//				//trace(pool);
 				pool[--counter].alpha = 1;
				return pool[counter];
			
			}else
				throw new Error("You exhausted the pool!");
		}
		
		public static function returnSprite(s:DisplayObject):void
		{
			
			pool[counter++] = s;
		}
	}
}