package com.jonLwiza.engine.baseConstructs{	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;	import com.jonLwiza.engine.actors.Hero;	import com.jonLwiza.engine.actors.Hornet;	import com.jonLwiza.engine.actors.Rings;	import com.jonLwiza.engine.helperTypes.Vector3;		import flash.events.Event;

	// this shit needs some rewriting but for now it works so yeah like for example it should sublcall GeneralActor	// but GeneralActor needs to take away all player specific things	public class NPC extends GeneralActor	{		private var _distToSonic:Number;		private var _screenDist:Number = 848;		private var spilled:Boolean;		private var _blocking:Boolean = false;		private var _bTree:Behaviour = new Behaviour(NPC(this));		private var _isHeld:Boolean = false;		// this gets deleted as well		protected var hero:Hero;		private var _live:Boolean = true;		private var _strike:Boolean;		private var _sonicCollision:Boolean				public function NPC()		{			super();		}						// I might get rid of this for optimization reasons since its really more info then i need but eh, should be fine, it only runs when they are alive, also its like one every five frames it updates dependent on its distance from sonic		// when i do more optimization i need to do a time check to see how far it is before running all these on enter frame events for now this is fine		// i set hero for all the guys		public function get sonicCollision():Boolean
		{
			return _sonicCollision;
		}		public function set sonicCollision(value:Boolean):void
		{
			_sonicCollision = value;
		}		override public function Update(h:Object = null):void		{			if(isWatched && !startedWatching){			FrameHandler.watchlist.push(this)			}			if(hero == null)			{			hero = Hero(h)			}else{			// I need to reroute it through the behavior itll have ls			UpdateDistToSonic();			// umm update might wanna find out what scene im in but for now we'll take sonic's scene and update it through there			// i was gonna do a scene specific movement, here nah we'll do that through group dynamics												}						//UpdateBtrees();			//animationSeq.tick();					}				public function UpdateDistToSonic():Number		{//			if(hero != null)			distToSonic = Math.sqrt((hero.X - X)*(hero.X - X)+(hero.Y - Y)*(hero.Y - Y)+(hero.Z - Z)*(hero.Z - Z));						if(live)			MainSceneMotor.UpdateZDepth(this);						if(distToSonic < screenDist || spilled)			{				bTree.tick();				DecloenatedUpdate();			}			return distToSonic;		}				// what the fuck does decloenated mean, was i high when i  wrote this		protected function DecloenatedUpdate():void		{			// TODO Auto Generated method stub					}						public function get screenDist():Number		{			return _screenDist;		}		public function set screenDist(value:Number):void		{			_screenDist = value;		}		public function get distToSonic():Number		{			return _distToSonic;		}		public function set distToSonic(value:Number):void		{			_distToSonic = value;		}		public function get bTree():Behaviour		{			return _bTree;		}		public function set bTree(value:Behaviour):void		{			_bTree = value;		}		public function get blocking():Boolean
		{
			return _blocking;
		}		public function set blocking(value:Boolean):void
		{
			_blocking = value;
		}		public function get live():Boolean
		{
			return _live;
		}		public function set live(value:Boolean):void
		{
			_live = value;
		}		public function get isHeld():Boolean
		{
			return _isHeld;
		}		public function set isHeld(value:Boolean):void
		{
			_isHeld = value;
		}		public function get strike():Boolean
		{
			return _strike;
		}		public function set strike(value:Boolean):void
		{
			_strike = value;
		}			}}