package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.baseConstructs.Baddie;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Status;
	
	import starling.display.Image;
	
	public class BrokenRubble extends MainScene
	{
		
		public function BrokenRubble()
		{
			super();
			atlas.push("BeachScntxtr1")
		}
		
		override public function Attacking(actor:GeneralActor):String
		{
			
			return Status.S_FAILURE
			
		}
		
		override public function Waiting(actor:GeneralActor):String
		{
			var a:Hornet = Hornet(actor)
			//	a.shape.sensorEnabled = false;
			a.Animateto("brknMess")
			return Status.S_SUCCESS;
		}
		
		
		override public function HeldOn(actor:GeneralActor):String{
			
				return Status.S_FAILURE
			
		}
		
	}
}