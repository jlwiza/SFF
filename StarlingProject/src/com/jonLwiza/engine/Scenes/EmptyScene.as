package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;

	public class EmptyScene extends MainScene
	{
		public function EmptyScene()
		{
			super();
		}
		
		
		/**
		 * 
		 * @param actor
		 * 
		 * this is an actor u put in for the thing
		 */
		override public function Update(actor:Hero = null):void
		{
			
			
		}
		
	}
}