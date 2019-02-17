package com.jonLwiza.engine.baseConstructs{	//import com.jonLwiza.engine.StateMachine;	import com.jonLwiza.engine.IO.KeyPress;	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;	import com.jonLwiza.engine.helperTypes.AnimationSequence;	import com.jonLwiza.engine.helperTypes.MState;	import com.jonLwiza.engine.helperTypes.Vector3;		import flash.geom.Vector3D;		import nape.callbacks.CbType;	import nape.phys.Body;		import starling.core.Starling;	import starling.display.Image;	import starling.display.MovieClip;
	public class GeneralActor extends GeneralAnimation	{		// its an array of the scenes that the actor is currently in		private var _triggerJumping:Boolean = false;		private var _doublejumped:Boolean = false;		private var _canJump:Boolean = true;		private var _stuck:Boolean = false;		private var _currScene:Array = new Array();		// just run a string in state machine, which is packed with an array of usuable from state, you can make em on the spot if you like, thats good if you want some weird functionality in a scene		//private var _stateMachine:StateMachine = new StateMachine();		protected var _key:Vector3 = new Vector3();		private var _inFight:Boolean = false;		private var _moveSpeed:Vector3 = new Vector3(7,5);		private var _jumpSpeed:Number = 0;		private var _life:Number = 1;		private var _defending:Boolean = false;		private var _attacking:Boolean = false;		private var _isJumping:Boolean = false;		private var _jumped:Boolean = false;		private var _moveVector:Vector3 = new Vector3();		private var _gv:Vector3 = new Vector3();		private var _isGrounded:Boolean;		private var _lineage:Array = new Array();		private var _target:Vector3= new Vector3();		// i wanna change this back to private if i end up not using this		private var _motorBTree:Behaviour = new Behaviour(GeneralActor(this));		private var _AnimBTree:Behaviour = new Behaviour(GeneralActor(this));		private var _SoundBTree:Behaviour = new Behaviour(GeneralActor(this));		private var _cutsIn:Boolean;		private var _animationSeq:AnimationSequence = new AnimationSequence(GeneralActor(this));		public var anim:String = "blink";		private var _dead:Boolean = false;		private var _invincible:Boolean = true;		private var _currentStatus:Behaviour;		private var _lastStatus:Behaviour;		private var _forward:Boolean;		private var _dir:int;		private var _currMBehaviour:String;		private var _currMBTree:String;		private var _skid:Boolean;		public var initialSkid:int;		public var autoRotate:Boolean = false;		private var _body:Body;		public var ParallelAnimation:Boolean;		private var _isWatched:Boolean = false		private var _startedWatching:Boolean = false		public static var Anim:MovieClip;		private var wIndex:uint;		public var localZ:Number = 0;		private var isAutoAtlas:Boolean = true;		/**it's only hero's proxy that's dealt with automatically, you'll have to set each proxy to null from moving scene to scen if you want an automatic follow**/		public var prxy:Vector3								public function GeneralActor()		{						super();			//dont override anim its part of the animation system it uses a frame named blink to default, it should be named default but yeah		}		// just be aware of your atlas when animating		override protected function createArtAsset():void		{			// since were dealing with some sort of actor we know it has behaviours and probably animation so we default on its creation by puting a default animation on to the thing which is "blink"			// its possible to pu this in the animation handler then when you actually have the resource overide the art asset creation, but if I put this here it forces something made using scenary archetect to be put in after and not 			// im not sure but i think this is a dynamic atlas loader 			trace(anim)			movie = new MovieClip(Assets.getAtlas(atlas[0]).getTextures(anim), 24);			movie.x = 0;			movie.y = 0;			starling.core.Starling.juggler.add(movie);			addChild(movie);			movie.alignPivot()		}				public function Update(h:Object = null):void{			UpdateBtrees()			if(updateZdepth){			MainSceneMotor.UpdateZDepth(this);			}		}		public function UpdateBtrees():void		{			// i dunno what this is about i may have deleted something by accident			//An			motorBTree.tick();			//AnimBTree.tick();			//SoundBTree.tick();			//for some reason i didnt put animationseq.tick here it may have been for testing, but it may have been for optimization			// for this we should check if its within camera to actually update the animation, but the animation isnt completely seperate from movement and updating for this to work effectively so for now just 			// put it here, but remember this is the first to go for animation stuff, because most this stuff will work perfectly if i leave it play animation								}				override public function Damage():void		{			// this is stupid but im so tired and Im not sure if i have a reason for doing it, so i dunno								}				protected function Damaged():void
		{
			
		}								public function DistTo(actr:GeneralActor):Number		{						return Math.sqrt((actr.X - X)*(actr.X - X)+(actr.Y - Y)*(actr.Y - Y)+(actr.Z - Z)*(actr.Z - Z));		}				public function DistToPoint(actr:Vector3):Number		{						return Math.sqrt((actr.X - X)*(actr.X - X)+(actr.Y - Y)*(actr.Y - Y)+(actr.Z - Z)*(actr.Z - Z)); 		}		public function DistToPointXY(actrX:Number,actrY:Number):Number		{						return Math.sqrt((actrX - x)*(actrX - x)+(actrY - y)*(actrY - y));		}						override public function get atlas():Array		{			if( currScene[0]){				if(_atlas != currScene[0].atlas && isAutoAtlas){					_atlas = currScene[0].atlas				}			}			return _atlas;		}		public function get target():Vector3
		{
			return _target;
		}		public function set target(value:Vector3):void
		{
			_target = value;
		}		public function get isGrounded():Boolean
		{
			return _isGrounded;
		}		public function set isGrounded(value:Boolean):void
		{
			_isGrounded = value;
		}		public function get jumped():Boolean
		{
			return _jumped;
		}		public function set jumped(value:Boolean):void
		{
			_jumped = value;
		}		public function get isJumping():Boolean
		{
			return _isJumping;
		}		public function set isJumping(value:Boolean):void
		{
			_isJumping = value;
		}		public function get jumpSpeed():Number
		{
			return _jumpSpeed;
		}		public function set jumpSpeed(value:Number):void
		{
			_jumpSpeed = value;
		}		public function get currScene():Array		{			return _currScene;		}		public function set currScene(value:Array):void		{			_currScene = value;		}		public function get key():Vector3
		{
			return _key;
		}		public function set key(value:Vector3):void
		{
			_key = value;
		}		public function get inFight():Boolean
		{
			return _inFight;
		}		public function set inFight(value:Boolean):void
		{
			_inFight = value;
		}		public function get gv():Vector3
		{
			return _gv;
		}		public function set gv(value:Vector3):void
		{
			_gv = value;
		}		public function get moveVector():Vector3
		{
			return _moveVector;
		}		public function set moveVector(value:Vector3):void
		{
			_moveVector = value;
		}		public function get moveSpeed():Vector3
		{
			return _moveSpeed;
		}		public function set moveSpeed(value:Vector3):void
		{
			_moveSpeed = value;
		}		public function get lineage():Array
		{
			return _lineage;
		}		public function set lineage(value:Array):void
		{
			_lineage = value;
		}		public function get motorBTree():Behaviour
		{
			return _motorBTree;
		}		public function set motorBTree(value:Behaviour):void
		{
			_motorBTree = value;
		}		public function get AnimBTree():Behaviour
		{
			return _AnimBTree;
		}		public function set AnimBTree(value:Behaviour):void
		{
			_AnimBTree = value;
		}		public function get SoundBTree():Behaviour
		{
			return _SoundBTree;
		}		public function set SoundBTree(value:Behaviour):void
		{
			_SoundBTree = value;
		}		public function get animationSeq():AnimationSequence
		{
			return _animationSeq;
		}		public function set animationSeq(value:AnimationSequence):void
		{
			_animationSeq = value;
		}		public function get cutsIn():Boolean
		{
			return _cutsIn;
		}		public function set cutsIn(value:Boolean):void
		{
			_cutsIn = value;
		}		public function get canJump():Boolean
		{
			return _canJump;
		}		public function set canJump(value:Boolean):void
		{
			_canJump = value;
		}		public function get triggerJumping():Boolean
		{
			return _triggerJumping;
		}		public function set triggerJumping(value:Boolean):void
		{
			_triggerJumping = value;
		}		public function get doublejumped():Boolean
		{
			return _doublejumped;
		}		public function set doublejumped(value:Boolean):void
		{
			_doublejumped = value;
		}		public function get defending():Boolean
		{
			return _defending;
		}		public function set defending(value:Boolean):void
		{
			_defending = value;
		}		public function get attacking():Boolean
		{
			return _attacking;
		}		public function set attacking(value:Boolean):void
		{
			_attacking = value;
		}		public function get dead():Boolean
		{
			return _dead;
		}		public function set dead(value:Boolean):void
		{
			_dead = value;
		}		public function get invincible():Boolean
		{
			return _invincible;
		}		public function set invincible(value:Boolean):void
		{
			_invincible = value;
		}		public function get currentStatus():Behaviour
		{
			return _currentStatus;
		}		public function set currentStatus(value:Behaviour):void
		{
			_currentStatus = value;
		}		public function get lastStatus():Behaviour
		{
			return _lastStatus;
		}		public function set lastStatus(value:Behaviour):void
		{
			_lastStatus = value;
		}		public function get forward():Boolean
		{
			return _forward;
		}		public function set forward(value:Boolean):void
		{
			_forward = value;
		}		public function get stuck():Boolean
		{
			return _stuck;
		}		public function set stuck(value:Boolean):void
		{
			_stuck = value;
		}		public function get dir():int
		{
			return _dir;
		}		public function set dir(value:int):void
		{
			_dir = value;
		}		public function get currMBTree():String
		{
			return _currMBTree;
		}		public function set currMBTree(value:String):void
		{
			_currMBTree = value;
		}		public function get currMBehaviour():String
		{
			return _currMBehaviour;
		}		public function set currMBehaviour(value:String):void
		{
			_currMBehaviour = value;
		}		public function get skid():Boolean
		{
			return _skid;
		}		public function set skid(value:Boolean):void
		{
			_skid = value;
		}		public function get body():Body
		{
			return _body;
		}		public function set body(value:Body):void
		{
			_body = value;
		}		public function get isWatched():Boolean
		{
			return _isWatched;
		}		public function set isWatched(value:Boolean):void
		{			if(value)			{			FrameHandler.watchlist.push(this)			wIndex = FrameHandler.watchlist.length - 1;			}			else{			FrameHandler.watchlist.splice(wIndex,1)			}
			_isWatched = value;			
		}		public function get startedWatching():Boolean
		{
			return _startedWatching;
		}		public function set startedWatching(value:Boolean):void
		{
			_startedWatching = value;
		}		public function get life():Number
		{
			return _life;
		}		public function set life(value:Number):void
		{
			_life = value;
		}	}}