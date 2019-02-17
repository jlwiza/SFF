package com.jonLwiza.engine.baseConstructs{	import com.jonLwiza.engine.Main;	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;	import com.jonLwiza.engine.helperTypes.Vector3;		import flash.geom.Vector3D;		import away3d.containers.ObjectContainer3D;	import away3d.entities.Mesh;	import away3d.materials.ColorMaterial;	import away3d.primitives.CubeGeometry;		import nape.shape.Shape;		import starling.display.Graphics;	import starling.display.Image;	import starling.display.Sprite;	import starling.events.Event;	import starling.utils.Color;

	public class GeneralMotor extends Sprite	{		private var _isFrozen:Boolean = false		private var _motorAnim:String;		private var _shape:Shape		// if you wanna move the character use these		private var _X:Number = 45;		private var _Y:Number = 0;		private var _Z:Number = 0;		private var _z:Number		private var _depth:Number = 100		private var _currAngle:Number = 0		private var _rotationY:Number = 0		public var my3dRep:ObjectContainer3D		private var _updateZdepth:Boolean = true;		private var _scaleZ:Number = 1;		private var _facingAngle:Number		public var obj2:Mesh;		private var _myAngle:Number;		private var _fkalpha:Number;		public var oldAlpha:Number = 1;		public var inAlter:Boolean = false;		private var _index:int		public var drctrIndx:int = -1		public var drctrList:Array = []		public var bdy:Vector3D = new Vector3D();		public var accel:Vector3D = new Vector3D();		public var vel:Vector3D = new Vector3D();						public function GeneralMotor() 		{			// I want a way 			super();			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			//my3dRep = set3dRep()		}		/** this is set up in such a way that if you call this in the away side you create the mesh and the picture seperately		 * then assign the mesh's coordinates to the picture, but from starling we just set up a default mesh and go, the beauty 		 * is u can always reassign the mesh its targeting at anytime **/		public function set3dRep(mesh:ObjectContainer3D = null):ObjectContainer3D
		{			// this might be much but well whatevs might wanna make this temp also since 			if(my3dRep){				my3dRep.dispose()				my3dRep = null								}			
			if(!mesh){				return createGeom()			}else{				return mesh			}
		}			public function Unproject(x:Number, y:Number, zDepth:Number):Vector3D{						return  LevelEditor.away3dView.unproject(x,y,zDepth)		}				/**		 * I put a line a awyObjadd child blah blah blah, just get rid of that if your not testing that should do it		 */		protected function createGeom():ObjectContainer3D
		{
			var awyObj:ObjectContainer3D = new ObjectContainer3D()				if(false){				awyObj = new Mesh(new CubeGeometry(),new ColorMaterial())					LevelEditor.away3dView.scene.addChild(awyObj)					obj2 = new Mesh(new CubeGeometry(),new ColorMaterial(Color.LIME))									}			return awyObj;			
		}				public function get scaleZ():Number
		{
			return _scaleZ;
		}		public function set scaleZ(value:Number):void
		{
			_scaleZ = value;
		}		private function onAddedToStage(e:Event):void
		{						
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			createArtAsset();
//			X = x;//			Y = y;			
		}		
		protected function createArtAsset():void
		{
			// TODO Auto Generated method stub			// everything has a sprite so it makes sense to put this herr besides making like an image class which would be done
			
		}
		public function hitTestObject(s:GeneralMotor, twoDimensional:Boolean = true):Boolean		{			// i dunno what this garbage is but ill make it			var left1:Number, left2:Number;			var right1:Number, right2:Number;			var top1:Number, top2:Number;			var bottom1:Number, bottom2:Number;			var front1:Number, front2:Number;			var back1:Number, back2:Number;									//object1						top1 = Y - height*scaleZ/2;			bottom1 = Y + height*scaleZ/2;			left1 = X - width*scaleZ/2;			right1 = X + width*scaleZ/2;			front1 = Z - depth*scaleZ/2;			back1 = Z + depth*scaleZ/2;						// object2			top2 = s.Y - s.height*s.scaleZ/2;			bottom2 = s.Y + s.height*s.scaleZ/2;			left2 = s.X - s.width*s.scaleZ/2;			right2 =s.X + s.width*s.scaleZ/2;			front2 = s.Z - s.depth*s.scaleZ/2;			back2 = s.Z + s.depth*s.scaleZ/2;						if(left1 < left2 && left2 < right1 && top1 < top2 && top2 < bottom1 ||				left1 <left2 && left2 < right1 && bottom2 < bottom1 && top1 < bottom2 ||				left1 < right2 && right2 < right1 && top1 < top2 && top2 < bottom1 ||				left1 <right2 && right2 < right1 && bottom2 < bottom1 && top1 < bottom2 ||				left1 < left2 && left2 < right1 && top2 < top1 && bottom1 < bottom2 ||				right2 <right1 && left1 < right2 && top2 < top1 && bottom1 < bottom2 ||				top1 < top2 && top2 < bottom1 && left2 < left1 && right1 < right2 ||				bottom2 < bottom1 && top1 < bottom2 && left2 < left1 && right1 < right2)			{				if(twoDimensional){					return true				}								if(front1 < front2 && front2 < back1||					front1< back2 && back2 < back1||					front2 < front1 && front1 < back2||					front2 < back1 && back1 < back2)				return true			}			//			if (bottom1 < top2) return true;			//			if (top1 > bottom2) return true;			//						//			if (right1 < left2) return true;			//			if (left1 > right2) return true;						return false;		}		// i think i did this again.. not sure		protected function randomRange(max:Number, min:Number = 0):Number		{			return Math.random() * (max - min) + min;		}				protected function randomIntRange(max:int, min:int = 0):int		{			return Math.random() * (max - min) + min;		}		public function UpdatePlacement(Coordinates:Vector3, state:String = null):void		{			// the hell is this?			Z += Coordinates.Z;			X += Coordinates.X;			Y += Coordinates.Y;			motorAnim = state;					}		public function Damage():void		{			// this is meant to be overridden but for quick demonstrations its nice to have because its quick dirty and you get whats going on			Destroy();		}						public function Destroy():void		{						this.dispose()			//this = null;		}						public function get motorAnim():String		{			return _motorAnim;		}				public function set motorAnim(value:String):void		{			_motorAnim = value;		}		public function get X():Number
		{			if(my3dRep){				return my3dRep.x;			}else{				return _X 			}
		}		public function set X(value:Number):void
		{			if(my3dRep){				my3dRep.x = value;			}else{				_X = value			}
		}		public function get Y():Number
		{
			if(my3dRep){				return my3dRep.y;			}else{				return _Y 			}
		}		public function set Y(value:Number):void
		{
			if(my3dRep){				my3dRep.y = value;			}else{				_Y = value			}
		}		public function get Z():Number
		{
						if(my3dRep){				return my3dRep.z;			}else{				return _Z 			}
		}		public function set Z(value:Number):void
		{			if(my3dRep){
			my3dRep.z = value;			}else{				_Z = value			}
		}		public function get isFrozen():Boolean
		{
			return _isFrozen;
		}		public function set isFrozen(value:Boolean):void
		{
			_isFrozen = value;
		}		public function get depth():Number
		{
			return _depth;
		}		public function set depth(value:Number):void
		{
			_depth = value;
		}		public function get currAngle():Number
		{
			return _currAngle;
		}		public function set currAngle(value:Number):void
		{
			_currAngle = value;
		}		public function get shape():Shape
		{
			return _shape;
		}		public function set shape(value:Shape):void
		{
			_shape = value;
		}		public function get rotationY():Number
		{
			return _rotationY;
		}		public function set rotationY(value:Number):void
		{
			_rotationY = value;
		}		public function get updateZdepth():Boolean
		{
			return _updateZdepth;
		}		public function set updateZdepth(value:Boolean):void
		{
			_updateZdepth = value;
		}		override public function set x(value:Number):void{			super.x = value		   			// ughh this is an absolute messy hack buuut yeah, im gonna go ballsy here if it breaks something so be it//			if(!updateZdepth){//			var unp:Vector3D = MainSceneMotor.Unproject(new Vector3D(this.x,this.y,this.zp))//			X = unp.x//			Y = unp.y//			Z = unp.z//			}		}		override public function get x():Number{			return super.x					}		override public function get y():Number{			return super.y					}				override public function set y(value:Number):void{									super.y = value//			if(!updateZdepth){//			var unp:Vector3D = MainSceneMotor.Unproject(new Vector3D(this.x,this.y,this.zp))//			// cool idea but I dont think it works at all//			X = unp.x//			Y = unp.y//			Z = unp.z//			}		}		public function get zp():Number		{						return _z;		}				public function set zp(value:Number):void		{			_z = value;		}				public function get z2():Number		{			var prjct:Vector3D  = LevelEditor.away3dView.project(new Vector3D(this.X,this.Y,this.Z))						return prjct.z;		}				/**z2 is special as it actually updates the XYZ values the others dont		 * */		public function set z2(value:Number):void		{			_z = value;						var unp:Vector3D = LevelEditor.away3dView.unproject(this.x,this.y,_z)			X = unp.x			Y = unp.y			Z = unp.z		}				public function get facingAngle():Number
		{						
			return currAngle*180/Math.PI - LevelEditor.away3dView.rotationY*180/Math.PI;
		}//		/** when setting the facing angle give it the camera Angle, set myAngle based on whether it's on or off the path**///		public function set facingAngle(camAngle:Number):void
//		{
//			_facingAngle = camAngle - currAngle;
//		}		public function get myAngle():Number
		{
			return _myAngle;
		}		public function set myAngle(value:Number):void
		{
			_myAngle = value;
		}		public function get fkalpha():Number
		{
			return _fkalpha;
		}		public function set fkalpha(value:Number):void
		{			
												if(alpha != 0 || _fkalpha == 0){				if(value != oldAlpha && _fkalpha !=0){					oldAlpha = alpha				}				alpha = value			}			_fkalpha = value;						
		}		public function get index():int
		{			this.parent.getChildIndex(this)
			return _index;
		}		public function set index(value:int):void
		{			this.parent.setChildIndex(this,value)
			_index = value;
		}			}}