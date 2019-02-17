package com.jonLwiza.engine.helperTypes
{
	import com.jonLwiza.engine.baseConstructs.Behaviour;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	//import flashx.textLayout.elements.BreakElement;
	
	public class AnimationSequence extends Behaviour
	{
		protected var _childNodes:Array = new Array();
		protected var currentChild:Behaviour = new Behaviour();
		protected var i:uint;
		 
		private var anim:String;
		private var from:String;
		private var _to:String;
		private var aSeq:ASeq = new ASeq()
		private var completeTweens:Vector.<String> = Vector.<String>(["sonicJoggingTOsonicSkid","sonicWalkingTOsonicJogging","sonicJumpFallingTOsonicSkid","sonicPissedTOsonicPissed","sonicJumpFallingTOsonicWalking","sonicFallingTOsonicRunning","sonicFallingTOsonicFalling","sonicSkidTOsonicSkid","sonicJumpFallingTOsonicRunning","sonicJumpFallingTOsonicSprinting","sonicJumpFallingTOsonicJumpFalling","sonicIdleTOsonicWalking","sonicSkidTOsonicSkid","sonicRisingTOsonicRising","sonicRollingTOsonicRolling","thisTOthat","defaultTOsomething", "somethingTOsomethingElse","sonicRisingTOsidewaysrunloop","sonicRisingTOsonicdying","sonicRisingTOsonicFalling","sonicRisingTOsonicHanging","sonicwaitingTOsonicCharging","sonicwaitingTOsonicDucking","sonicwaitingTOsonicDying","sonicwaitingTOsonicFalling","sonicwaitingTOsonicHanging","sonicwaitingTOsonicJumpRising","sonicwaitingTOsonicWalking","sonicJoggingTOsonicJogging","sonicJoggingTOsonicRunning","sonicRunningTOsonicRunning","sonicWalkingTOsonicWalking","sonicPissedTOsonicJumpRising","sonicIdleTOsonicJumpRising","sonicWalkingTOsonicwaiting","sonicSkidTOsonicWalking","sonicPissedTosonicPissed"/*d*/]);
		private var _cutsIn:Boolean;
		
		public function AnimationSequence(actor:GeneralActor=null)
		{
			super(actor);
			from = "blink";
			
		}
		
		
		override public function initialize():void
		{
			run = true;
			aSeq.actor = actor;
			anim = from
			i = 0;
			// instead of just saying running to jumping is a good transfer, it says well there is a bunch of spikes over me, so i should either say no i dont wanna, or transfer it
			// to a jumpdeath instead of just a regular jump
			
		}
		
		override public function update():String
		{
			
			while(true)
			{
				
				if(aSeq.anim != actor.anim)
				aSeq.anim = actor.anim;
				
				status = aSeq.tick();
				
				// this code is so incredibly adorable i could of never came up with it by myself, too cute for my tastes
				
				
				if(actor.cutsIn){
					actor.straightto(anim);
//					//trace("this updated we'll set this to four outside and then 2", actor.anim);
					anim = actor.anim;
					from = anim;
					to = null;
					i = 0;
					// just go to and play this frame animationAthingymabob
					// it just means we play some animation from the beginning
					actor.cutsIn = false
						// again not necessary nice cap though, so yeah BOOOLLLINNN
						return Status.S_RUNNING
				}
				
				
				if(status != Status.S_SUCCESS)
				{
					return status;
				}
				
				actor.trani = false;
				////trace(i);
				// this may break if it goes out of the loop
				if(to != null)
				{
				i++;
				}else{
						////trace("NO FRAME ANIMATION TO TRANSITION TO");
						return Status.S_RUNNING;
				}
				switch(i)
				{
					case 0:
					{
						if(actor.anim!= from)
						actor.anim = from;
						break;
					}
					case 1:
					{
						// when this is all done this might be better put in editor code not in release code, in release just set anim to from+"to"+to
						for (var k:int = 0; k < completeTweens.length; k++) 
						{
						 if(completeTweens[k]/*[0]*/ == from+"TO"+to)
						 {
							 
							 actor.trani = true;
							 actor.anim = from+"TO"+to;
							 break;
						 }
						 
						 if( k == completeTweens.length - 1)
						 {
							//search transition ::::
//							 //trace("THE TRANSITIONAL FRAME ANIMATION",from+"TO"+to,"WAS NOT FOUND, WILL DEFAULT TO",to+".");
							 i = 0;
							 actor.anim = to;
							 from = actor.anim
							 to = null;
							 //not neccessaryu but nice cap
							 break;
							 
						 }
						}
						
						
						//anim = from+"TO"+to; 
						break;
					}
					case 2:
					{
						i = 0;
						actor.anim = to;
						from = actor.anim
						to = null;
					}
						
					default:
					{
						break;
					}
				}
				
				if(i== 3)
				{
					i==0;
					from = to;
					to = null;
					
				}
				
				//return Status.S_RUNNING
				
			}
			
			
			
			// update returns a status anything besides invalid, invalid is just so init runs once
			return Status.S_INVALId
		}
		// one of the functions the most important plays a set number of frames before sending it a notification, for the jump
		//also keep track of the animations, honestly just build it up function by function
		// in the array your also sent a array of what frames you can change froms and where itll connect on the to frame, if thats necessary
		public function someThingItDoes():void
		{
			
		}
		
		override public function exit(status:String):void
		{
			
		}

		public function get to():String
		{
			return _to;
		}

		public function set to(value:String):void
		{
			_to = value;
		}

		public function get cutsIn():Boolean
		{
			return _cutsIn;
		}

		public function set cutsIn(value:Boolean):void
		{
			_cutsIn = value;
		}
		
		
		
	}
}