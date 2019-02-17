package com.jonLwiza.engine.actors
{
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Status;
	
	import starling.display.Image;
	
	public class Cars extends Hornet
	{
		//updating distance and what not is unnessary
		public function Cars(im:String = "Cars")
		{
			super(null);
		}
		
		
//		override protected function createArtAsset():void
//		{
//			
//			var imge:Image = new Image(Assets.getTexture("Cars"));
//			imge.x = 0
//			imge.y = 0
//			addChild(imge);
//			
//			
//		}
		
		override protected function wait():void
		{
			// might  consider making a moveback state
			//UpdateDistToSonic()
			straightto("driving")
		}
		override public function BaddieBehavior():String{
			return Status.S_FAILURE
		}
		
		override public function Attacking():String
		{
			
			return Status.S_FAILURE
			
		}
		
		
		
		
		override public function Held():String{
			
			return Status.S_FAILURE
			
		}
	}
}