package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.baseConstructs.Baddie;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Status;
	
	import flash.utils.getQualifiedClassName;
	
	import starling.display.Image;
	// you can opt to either extend main scene so this can be simpler, and more broad in scope, but since this
	// it only really makes sense to extend the specific cut if I do something in the cut that broadly effects the style of
	//play like swimming or a minigame of somesort the beachscene makes sense since their might be times it goes and starts
	//swimming or something like that
	public class BrokenHornet extends MainScene
	{
		private var imageNotChanged:Boolean;
		public function BrokenHornet()
		{
			// once you put animations in there, the different animations will change its apeal for now it will be represented as a hornet
			// make sure to signal the animated scene to do stuff also
			super();
			atlas.push("BeachScntxtr1")
			//hero = Main.liveCamera.hero_mc
			hornetIdle = "brkenHornetIdle"
		}
		
		override public function Attacking(actor:GeneralActor):String
		{
			
			return Status.S_FAILURE
			
		}
		
		override public function Waiting(actor:GeneralActor):String
		{
			var a:Hornet = Hornet(actor)
			
			a.autoTrack = false;
			
			return Baddie(actor).Waiting();
			}
		
		
//		override public function HeldOn(actor:GeneralActor):String{
//			var h:Hornet = Hornet(actor)
//			
//		if(!h.isHeld || h.life == 0 || h.thrown)
//		{
//			if(h == hero.heldOnTo[0])
//				hero.heldOnTo =[];
//			return Status.S_FAILURE
//		}else{
//			hero.heldOnTo = [h];
//			//actually i dont anything right here except make sonics position equal this position
//			hold();
//			return Status.S_RUNNING
//		}
//		
//	}
		
//		private function hold():void
//		{
//			
//			// TODO Auto Generated method stub
//			
//		}
	}
}