package com.jonLwiza.engine.baseConstructs
{
	

	
	import com.jonLwiza.engine.helperTypes.Status;
	
	import starling.display.MovieClip;
	
	//import flashx.textLayout.factory.StringTextLineFactory;

	public class GeneralAnimation extends AnimationHandler
	{
		private var _animStatus:String;
		private var _looping:Boolean = false;
		public static var Anim:MovieClip = null;
		
		
		public function GeneralAnimation()
		{
			
			super();
			
		}
		
		public function AnimationStateUpdate(animation:String, cutsIn:Boolean = false, loop:Boolean = false):String
		{
			
			//looping = loop;
			if(cutsIn){
				GeneralActor(this).cutsIn = true;
				GeneralActor(this).anim = animation
				return Status.S_RUNNING
			}else{
			if(loop){
				
				// i dunno this just seems fishy i get it and now i understand it wasnt broken but something just doesnt feel efficient about it
			GeneralActor(this).animationSeq.to = animation
				return Status.S_RUNNING
			}else{
				
				if(animation != GeneralActor(this).anim)
				{
					GeneralActor(this).animationSeq.to = animation;
					return Status.S_RUNNING
				}else{
				return animStatus
				// the problem with this is one thing this returns success at the end of the damn thing, which isnt 
				}
			}
			}
				//playAnimation(animation);
			
			
			
		}

	

		public function get animStatus():String
		{
			return _animStatus;
		}

		public function set animStatus(value:String):void
		{
			_animStatus = value;
		}

		public function get looping():Boolean
		{
			return _looping;
		}

		public function set looping(value:Boolean):void
		{
			_looping = value;
		}

		


//		public function get animationSeq():AnimationSequence
//		{
//			return _animationSeq;
//		}
//
//		public function set animationSeq(value:AnimationSequence):void
//		{
//			_animationSeq = value;
//		}
		

	}
}