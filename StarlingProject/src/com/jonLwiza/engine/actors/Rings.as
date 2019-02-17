package com.jonLwiza.engine.actors
{
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.NPC;
	
	import starling.display.Image;
	
	final public class Rings extends NPC
	{
		private var minDist:int =100;
		private var spilled:Boolean;
	
		
		public function Rings()
		{
			super();
			minDist = width+8;
			drctrList = Director.rings
			
		}
		
		
		//*********TEMPCODE**************
//		override protected function createArtAsset():void
//		{
//			var imge:Image = new Image(Assets.getTexture("Ring"));
//			imge.x = 0;
//			imge.y = 0;
//			addChild(imge);
//		}
		
		override protected function DecloenatedUpdate():void
		{
			
			straightto("sonicRunning")
			
			if(distToSonic < minDist)
			{
			Gather();
			hero.rings++
			}
			if(spilled){
				
			}
			
//			if(live)
//			MainSceneMotor.UpdateZDepth(this);
			
		}
		
		private function Gather():void
		{
			// TODO Auto Generated method stub
			this.X = -9001;
		this.Y = -9001;
		this.alpha = 0;
		
		}
		
		override public function Destroy():void
		{
		
		}
		
	}
}