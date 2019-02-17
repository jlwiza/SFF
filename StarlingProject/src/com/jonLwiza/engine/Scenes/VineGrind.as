package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Vector3;
	import com.jonLwiza.engine.state.sonicBehavior.Hanging;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;

	public class VineGrind extends MainScene
	{
		public function VineGrind()
		{
			super();
			sonicIdle = "hangingIdle";
			sonicPissed = "hangingIdle";
			sonicwaiting = "hangingIdle"
			sonicWalking = "hangingVine";
			sonicRunning = "vineGrinding";
			sonicJogging ="vineGrinding";
			sonicSprinting ="vineGrinding";
		}
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			if(hero.isGrounded)
			{
				// this may just slow the thing down but that is perfectly fine
				hero.key.X = 0;
			}
		}
		
	}
}