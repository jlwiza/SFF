package com.jonLwiza.engine.helperTypes
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class ASeq extends Behaviour
	{
		private var i:int = 0;
		private var _anim:String;
		public function ASeq(actor:GeneralActor=null)
		{
			super();
			
		}
		
		override public function initialize():void
		{
			run = false;
			if(actor.cutsIn)
			{
//				//trace(anim, "Cuts in");
			}
		}
		
		override public function update():String
		{
			
			//anim = "chargeSpin"
//			//trace("hj y ",anim);
			actor.animStatus = actor.playAnimation(anim);
			//cutsIn = actor.cutsIn
			////trace(cutsIn);
			//	cutsIn = true;
//			if(anim == "test"|| anim == "something" || anim == "somethingTOsomethingElse"){
//				i++
//			switch(i)
//			{
//				case 10:
//				{
//					////trace("we shoould be updating")
//					//cutsIn = actor.cutsIn
//					//cutsIn = true;
//					actor.animationSeq.to = "something";
//					status = Status.S_SUCCESS;
//					break;
//				}
//				case 20:
//				{
//					//trace("stuff");
//					status = Status.S_SUCCESS;
//					break;
//				}
//				case 30:
//				{
//					actor.animationSeq.to = "somethingElse";
//					status = Status.S_SUCCESS;
//					break;
//				}
//				case 40:
//				{
//					status = Status.S_SUCCESS;
//					break;
//				}
//					
//				default:
//				{
//					break;
//				}
//			}
//			}
			return actor.animStatus
		}

		public function get anim():String
		{
			return _anim;
		}

		public function set anim(value:String):void
		{
			_anim = value;
		}

		
	}
}