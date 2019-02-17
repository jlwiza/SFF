package com.jonLwiza.engine.baseConstructs{	//import Sonic_fla.thisthingy_30;		import com.jonLwiza.engine.GeneralElements.Director;	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;	import com.jonLwiza.engine.actors.Hero;	import com.jonLwiza.engine.helperTypes.Status;	import com.jonLwiza.engine.helperTypes.Vector3;		import flash.events.Event;		import starling.display.Sprite;	import starling.filters.FragmentFilter;
// this is ok that baddie, or even general actor are not triggers and scenes, one I can put them both in a scene easier without making a subscene, which is a scene that simply doesnt motor, its additive and cant subtract, but you can make it try to choose the subs function first before the other	public class Baddie extends NPC	{				protected var baddieType:String = null;		// is held will work for other things besides baddies so it should be moved up to npc				private var _distToSonic:Number = 0;		private var _minDist:int;		//private var hero:Hero;		// after we are done waiting, and while were waiting we update our attack target		private var _comfortZone:Number = 400;		private var attkTarget:Vector3 = new Vector3();		private var _satilite:Baddie;		private var maxDist:int = 200;		private var _focus:Vector3 = new Vector3();		private var _dx:Number = 0;		private var _dy:Number = 0;		private var _thrown:Boolean = false;		public var myFilter:FragmentFilter		private var _justAttacked:Boolean = false;		private var _waitTimeticker:int;		private var _waitTime:int;		private var _canAttack:Boolean = true;		private var _range:Number = 750;		private var _attackingState:Boolean = false;		private var _local:Boolean = true;		private var _isOnPath:Boolean = true;				public function Baddie()		{			super();						drctrList = Director.baddies//			if (enterScene ==  null) //			{//				currScene = [ms];//			}else{//				currScene= [enterScene];//			}									// i probably dont need to do this, consider i only load whats around me		//	this.parent.addEventListener(Event.ADDED_TO_STAGE, allLoaded);			this.scaleZ = 2						}								//		protected function allLoaded(event:Event):void//		{//			//trace(this, " Entered");//			hero = Hero(this.parent.getChildByName("hero_mc"))//			//cam = Camera(this.parent.parent.getChildByName("stage_mc"));//			//this.parent.removeEventListener(Event.ADDED_TO_STAGE, allLoaded);//		}				// it inherits this//		protected function allLoaded(event:Event):void//		{//			this.parent.removeEventListener(Event.ADDED_TO_STAGE, allLoaded);//			addEventListener(Event.ENTER_FRAME, OnEnterFrame);//			hero = Hero(this.parent.getChildByName("hero_mc"));//			//cam = Camera(this.parent.parent.getChildByName("stage_mc"));//		}				// when i do more optimization i need to do a time check to see how far it is before running all these on enter frame events for now this is fine		override public function Update(h:Object=null):void		{								if(hero == null)			{			hero = Hero(h);			}else{				// I made update z depth static but im thinking I might change that.. but probably not			// live is used for npcs its for optimization i dont want things moving around if Im not looking at them pretty much			if(live && updateZdepth)			MainSceneMotor.UpdateZDepth(this);			UpdateDistToSonic();			// this should be smarter later to be more efficient			if(!local && distToSonic < 2000){				local = true				h.localBaddies.push(this)					// let group dynamics take em out			}			UpdateBtrees()			motorBTree.tick();			if(_isOnPath && false){			currScene[0].msm.UpdatePhysicsActor(this)			}			////trace("btrees being updated")			//animationSeq.tick();			}		}				public function easeIn(sprite:GeneralActor, targetX:Number, targetY:Number, easing:Number = 0.5):void		{			sprite.X += (targetX - sprite.x)*easing;			sprite.Y += (targetY - sprite.y)*easing;		}		public function angleBtwnPts(pt1:Vector3, pt2:Vector3):Number		{			return Math.atan2(pt2.Y - pt1.Y, pt2.X - pt1.X);		}				override public function UpdateDistToSonic():Number		{			distToSonic = Math.sqrt((hero.X - X)*(hero.X - X)+(hero.Y - Y)*(hero.Y - Y)+(hero.Z - Z)*(hero.Z - Z));									return distToSonic		}				// these are what is replaced				public function BaddieBehavior():String		{			////trace("do it")			// this wouldnt work well with a type of game with punching, actually just change the distance to sonic to watch for the motion of its fists to the target and thatd work			if(attacking && (!hero.attacking || !hero.defending) && distToSonic < minDist )			hero.Damage();						if(hero.attacking && (!attacking || !defending) && distToSonic < minDist )			Damage();			if(currMBehaviour != "Throwing" && currMBehaviour != "Dead")			//trace(currMBehaviour)							badBehavior();						return Status.S_RUNNING;					}				protected function badBehavior():void
		{
			// extension to baddie Behavior 
		}				protected function BlockAttack():void		{			//canAttack = false		}				public function Dead():String		{			//death is very changeable depending on the scene and whatnot, most of the time its wait to be destroyed			// but a nice temp solution is just get rid of it			return Status.S_FAILURE		}		public function Waiting():String		{			// this is the last to get tried //			if((distToSonic > minDist && distToSonic < maxDist)|| isHeld || attacking)//			{									if(isHeld)			{				if(baddieType == null){				throw new Error("you forgot to name a Baddie type, its coming up as null");				}else{					if(baddieType == "hornet")					{						dx = 40;						dy = 20;						//this is where we make it a random + but right now for testing im just doing whatever fits 						focus.pos(hero.body.position.x,hero.body.position.y);											}				}				return Status.S_FAILURE			}else if(attackingState && !justAttacked){				return Status.S_FAILURE			}else if(life == 0){				return Status.S_FAILURE			}else{				if(waitTimeticker > waitTime)                 					BlockAttack();				else					waitTimeticker++										wait();				// Status.S_RUNNING is what it is				// its gonna first off Im think the bug bad guy now it should have its own tree like a follow pursue, but that can be added right now just chill and wait to be held				// do waiting stuff strangely enough itll update through what sonic does								return Status.S_RUNNING			}					}				protected function wait():void		{			// TODO Auto Generated method stub			// might wanna have a queed up state			// but here we if(Queed && !satilite.attacking){attacking = true}		}								public function Attacking():String		{						// this is the last to get tried 			if(!attackingState || dead)			{				// do the swooping in and what not				return Status.S_FAILURE			}else{//				if(canAttack)//				canAttack = false;				attack();								if(waitTimeticker>0)				waitTimeticker = 0				//if(quick timer > waitTime){ attack()}				//elseqtime++				//um basically just attack and when your finish turns yoSelf off				return Status.S_RUNNING			}		}				protected function attack():void
		{
			// TODO Auto Generated method stub
			
		}				public function Held():String		{			//  have to add other exits as well I dont know what right now			if(!isHeld || life == 0 || thrown)			{				if(this == hero.heldOnTo[0])				hero.heldOnTo =[];				return Status.S_FAILURE			}else{				hero.heldOnTo = [this];				//actually i dont anything right here except make sonics position equal this position				hold();				return Status.S_RUNNING			}		}				protected function hold():void		{			// TODO Auto Generated method stub					}				public function Thrown():String		{			if(!thrown)			{				return Status.S_FAILURE			}else{				throwBaddie();				return Status.S_RUNNING							}		}				public function throwBaddie():void
		{
			
		}								override public function get distToSonic():Number		{			return _distToSonic;		}		override public function set distToSonic(value:Number):void		{			_distToSonic = value;		}		public function get minDist():int		{			return _minDist;		}		public function set minDist(value:int):void		{			_minDist = value;		}		public function get focus():Vector3
		{
			return _focus;
		}		public function set focus(value:Vector3):void
		{
			_focus = value;
		}		public function get dx():Number
		{
			return _dx;
		}		public function set dx(value:Number):void
		{
			_dx = value;
		}		public function get dy():Number
		{
			return _dy;
		}		public function set dy(value:Number):void
		{
			_dy = value;
		}		public function get thrown():Boolean
		{
			return _thrown;
		}		public function set thrown(value:Boolean):void
		{
			_thrown = value;
		}		public function get satilite():Baddie
		{
			return _satilite;
		}		public function set satilite(value:Baddie):void
		{
			_satilite = value;
		}				public function get justAttacked():Boolean		{			return _justAttacked;		}				public function set justAttacked(value:Boolean):void		{			_justAttacked = value;		}		public function get comfortZone():Number
		{
			return _comfortZone;
		}		public function set comfortZone(value:Number):void
		{
			_comfortZone = value;
		}		public function get canAttack():Boolean
		{
			return _canAttack;
		}		public function set canAttack(value:Boolean):void
		{
			_canAttack = value;
		}		public function get waitTime():int
		{
			return _waitTime;
		}		public function set waitTime(value:int):void
		{
			_waitTime = value;
		}		public function get range():Number
		{
			return _range;
		}		public function set range(value:Number):void
		{
			_range = value;
		}		public function get attackingState():Boolean
		{
			return _attackingState;
		}		public function set attackingState(value:Boolean):void
		{
			_attackingState = value;
		}		public function get local():Boolean
		{
			return _local;
		}		public function set local(value:Boolean):void
		{
			_local = value;
		}		public function get isOnPath():Boolean
		{
			return _isOnPath;
		}		public function set isOnPath(value:Boolean):void
		{
			_isOnPath = value;
		}		public function get waitTimeticker():int
		{
			return _waitTimeticker;
		}		public function set waitTimeticker(value:int):void
		{
			_waitTimeticker = value;
		}			}}