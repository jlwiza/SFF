package com.jonLwiza.engine.baseConstructs
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.actors.Rings;
	
	import flash.geom.Vector3D;
	
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	
	import sprite.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class NSprite extends Sprite
	{
		private var _X:Number = 0;
		private var _Y:Number = 0;
		private var _Z:Number = 0;
		private var _live:Boolean = true;
		private var _updateZdepth:Boolean = true;
		private var _x:Number;
		private var _y:Number;
		private var _scaleZ:Number = 1;
		private var _z:Number = 900;
		private var _fkalpha:Number ;
		public var oldAlpha:Number = 1;
		public static var nsprites:Array = new Array();
		public function NSprite(startDist:Number = 900)
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			nsprites.push(this)
//			var st:Vector3D = LevelEditor.away3dView.unproject(0,0,startDist)
//				X = st.x
//				Y = st.y
//				Z = st.z
//				var bmap:Bitmap = new Assets["Ring"]()
//				addChild(bmap);
					//this.
				
		}
		
		private function  onAddedToStage(e:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		}
		public function Update():void
		{
			
			//var hero:ObjectContainer3D = MainStage.lookAtTarget
			
			// i dont think i need this
			//var distToSonic:Number = Math.sqrt((hero.x - X)*(hero.x - X)+(hero.y - Y)*(hero.y - Y)+(hero.z - Z)*(hero.z - Z));
			
			
			
				// I made update z depth static but im thinking I might change that.. but probably not
				// live is used for npcs its for optimization i dont want things moving around if Im not looking at them pretty much
			if(live && updateZdepth){
				MainSceneMotor.UpdateZDepth(this)
				//Main.liveCamera.UpdateZDepth(this);
			}
			//oldAlpha
//			if(z<=0  || x >= 800 || y >= 600){
//				alpha = 0
//			}
			
			}

		override public function set x(value:Number):void{
			super.x = value
		}
		override public function get x():Number{
			return super.x
			
		}
		override public function get y():Number{
			return super.y
			
		}
		
		override public function set y(value:Number):void{
			super.y = value
				
			
		}
		public function get X():Number
		{
			return _X;
		}

		public function set X(value:Number):void
		{
			_X = value;
		}

		public function get zp():Number
		{
			return _z;
		}
		
		public function set zp(value:Number):void
		{
			_z = value;
			
			
		}
		
		public function get Y():Number
		{
			return _Y;
		}

		public function set Y(value:Number):void
		{
			_Y = value;
		}

		public function get Z():Number
		{
			return _Z;
		}

		public function set Z(value:Number):void
		{
			_Z = value;
			
		}

		public function get live():Boolean
		{
			return _live;
		}

		public function set live(value:Boolean):void
		{
			_live = value;
		}

		public function get updateZdepth():Boolean
		{
			return _updateZdepth;
		}

		public function set updateZdepth(value:Boolean):void
		{
			_updateZdepth = value;
		}
		public function get scaleZ():Number
		{
			return _scaleZ;
		}
		
		public function set scaleZ(value:Number):void
		{
			_scaleZ = value;
		}
		public function get fkalpha():Number
		{
			return _fkalpha;
		}
		
		public function set fkalpha(value:Number):void
		{
			
			// the fuck does this do and why the fuck is it here?!!!
			// I think it may be a stupid version of the one two
			
			
			if(alpha != 0 || _fkalpha == 0){
				if(value == 0 && _fkalpha !=0){
					oldAlpha = alpha
				}
				alpha = value
			}
			_fkalpha = value;
		}
	}
}