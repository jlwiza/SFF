package com.jonLwiza.engine.actors
{
	import com.jonLwiza.engine.IO.KeyPress;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.helperTypes.Status;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import starling.display.Image;
	import starling.utils.rad2deg;

	public class BigBaddie extends Hornet
	{
		private var _angleToSonic:Number;
		private var serag:int;
		private var picked:Boolean;
		private var attackAngle:String;
		public var head:AnimatedScenary
		public var tail:AnimatedScenary
		public var elbow:AnimatedScenary
		public var shoulder:AnimatedScenary
		private var deadZone:int = 10;
		public function BigBaddie(im:String = "bigB")
		{
			super(null);
		}
		
		override public function Update(h:Object = null):void
		{
			
			if(hero == null)
			{
				hero = Hero(h);
			}else{
				if(live)
					MainSceneMotor.UpdateZDepth(this);
				UpdateDistToSonic();
				angleToSonic = Math.atan2(Z - hero.Z,X - hero.X)
				// this should be smarter later to be more efficient
				if(!local && distToSonic < 2000){
					local = true
					h.localBaddies.push(this)
					// let group dynamics take em out
				}
				UpdateBtrees()
				motorBTree.tick();
				////trace("btrees being updated")
				//animationSeq.tick();
			}
			
		}
		
		override protected function wait():void
		{
			// might  consider making a moveback state
			//UpdateDistToSonic()
			straightto("bigBidling")
			//hmm this isnt how it sould be done but ill get its movemont here
			//and do the code for it over here aswell it's pretty easy just moving around
			if(vel.x>0+deadZone/2){
				straightto("bigRunRight")
			}else if(vel.x<0-deadZone/2){
			//	straightto("bigRunLeft")
			}
			
			if(distToSonic < 300){
				attackingState = true;
			}
//			if(!moveBack){
//				origin.X = hero.x;
//				origin.Y = hero.y - 90;
//			}
//			
//			if(justAttacked){
//				shape.scale(2,2)
//				started = false
//				timeTocanAttack = waitTime;
//				justAttacked = false;
//			}
//			if(timeTocanAttack > 0)
//				timeTocanAttack--;
//			else
//			canAttack = true;
//			// this is the code you get rid of if group dynamics is on, and im leaning towards getting it working again, but only as polish as it adds
//			// variety in the ways the fight can go
//			//			if(canAttack){
//			//			attackingState = true
//			//			timeTocanAttack = 25
//			//				}
//			
//			
//			// I need to move this to group dynamix too itll help also cuz then i can more cleverly use hitTest, so two of em dont get hanged from
//			if(sonicCollision && hero.key.Y == -1 && !hero.hanging)
//			{
//				isHeld = true;
//				hero.hanging = true;
//				KeyPress.spacebar = false;
//				hero.spacebar = false
//			}else{
//				
//			}
			
			// this is the special animation thats not time based that is position based, and makes it go step by step
			// note we could layer in animation on top of this if we wanted we would just have to make a local home position or whatever
			//			if(moveBack){
			//				// that hanim pos is terrible naming itll get confusing real quick.. oh well
			//			// alright to bypass this multiple animation on different things and layers of animation problem there are two solutions, create a new incrementor for every different animation, or a new class, a new class has more overhead and will needed to create a new instance everytime so i think im just gonna do it a straight up way like sososososososossososososososososooooooooo
			//			
			//			//remember use function for expansion, this is very rough and dumb	
			//			
			//				if(greaterThan){
			//				easeIn(this,testHAnim[backtoHomeAfterAttack][0]+ origin.X,testHAnim[backtoHomeAfterAttack][1] + origin.Y, 1/8)
			//				if(DistToPointXY(testHAnim[backtoHomeAfterAttack][0]+ origin.X,testHAnim[backtoHomeAfterAttack][1]+ origin.Y) < incrDist)
			//					backtoHomeAfterAttack++;
			//				}else{
			//					easeIn(this,lessthanSonic[backtoHomeAfterAttack][0]+ origin.X,lessthanSonic[backtoHomeAfterAttack][1] + origin.Y, 1/8)
			//					if(DistToPointXY(lessthanSonic[backtoHomeAfterAttack][0]+ origin.X,lessthanSonic[backtoHomeAfterAttack][1]+ origin.Y) < incrDist)
			//						backtoHomeAfterAttack++;
			//				}
			////			
			//					//this can be expanded to include any types of movement replace testHanim 1 and 2 with blank variables determine what kind of return you want from the conception of attack so maintaining whatever flow is easy 
			////			        May just change it all into a function in hard animation class and place the name into the thingy, yeah thats better
			////			
			////			
			//				////trace(DistToPointXY(testHAnim[backtoHomeAfterAttack][0]+ origin.X,testHAnim[backtoHomeAfterAttack][1]+ origin.Y));
			//					
			//				
			//				
			//				if (backtoHomeAfterAttack == testHAnim.length) 
			//				{
			//					moveBack = false;
			//					backtoHomeAfterAttack = 0; 
			//				}
			//			
			//				
			//			}
			
			
			
			//easeIn(this,homingPos);
			
			X+= vel.x
			Z+= vel.z
		}
		
		override public function BaddieBehavior():String
		{
			return Status.S_FAILURE
		}
		
		override protected function attack():void
		{
			// different attacks
			
			//straightto("bigBattack")
			// not bad may use
			
//			if(distToSonic < 200){
//				closeAttack()
//			}else if(distToSonic >= 200 &&distToSonic < 400){
//				MidAttack()
//			}else{
//				farAttack()
//			}
		}
		
		private function farAttack():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function MidAttack():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function closeAttack():void
		{
			if(!picked){
				if(rad2deg(angleToSonic)<225){
					attackAngle = "leftAttack"
				}else if(rad2deg(angleToSonic)>=225 && rad2deg(angleToSonic)<=315){
					attackAngle = "MidAttack"
				}else if(rad2deg(angleToSonic)>315){
					attackAngle = "RightAttack"
				}
			serag = randomIntRange(2)
			picked = true
			}
			switch(serag)
			{
				case 0:
				{
					Swipe()
					break;
				}
				case 1:
				{
					Throw()
					break;
				}
				case 2:
				{
					Bite()
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		private function Bite():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function Throw():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function Swipe():void
		{
			// TODO Auto Generated method stub
			
		}
		//		override public function Attacking():String
//		{
//			
//			return Status.S_FAILURE
//			
//		}
		
		
		override public function Held():String
		{
			
			return Status.S_FAILURE
			
		}

		public function get angleToSonic():Number
		{
			return _angleToSonic;
		}

		public function set angleToSonic(value:Number):void
		{
			_angleToSonic = value;
		}

	}
}