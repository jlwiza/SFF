package {  
	import com.greensock.motionPaths.LinePath2D;
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.NSprite;
	
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import away3d.entities.SegmentSet;
	import away3d.primitives.LineSegment;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	import starling.utils.LineSet;
	
	
	
	public class BezierCurve extends NSprite {  
		
		//public static  var curve:Array = [];  
		private var _point1:NSprite = new NSprite();  
		private var _point2:NSprite = new NSprite();  
		public var _control2:NSprite = new NSprite() 
		private var _line:LineSet   
 		private var _NSprite:NSprite = new NSprite();  
		
		private var _update:Boolean = false;  
		private var _curvePoints:int = 5;  
		private var _step:Number
		private var _animate:Boolean = false;  
		
		private var linePath:LinePath2D;  
		private var angle:Number;  
		private var a:Number = 0.01;  
		private var progress:Number = 0;  
		public  var _control1:NSprite = new NSprite();
		private var v:Vector3D = new Vector3D();
		private var v2:Vector3D = new Vector3D();
		private var p:flash.geom.Point;
		private var CbezPts:Array = [];
		private var _bezierPts:Array = [];
		public  var bCntrlPts:Array = [];
		
		// i might put s from the outside in here when i make the circles we'll see
		public var isUpdate:Boolean;
		public  var curve:Array = [];
		
		//private var pp:PerspectiveProjection = new PerspectiveProjection();
		private var oldY:Number = 0;
		private var newY:Number = 0;
		private var deltaY:Number;
		public var drag:Boolean;
		
		private var s:NSprite;
		private var shiftDragging:Boolean = false;
		private var i2:int = 0;
		public static var segs:Array = [];
		private var lineNSprites:Vector.<NSprite> = new Vector.<NSprite>();
		private var _selectedBezier:Array = [];
		private var bezier:int = 1;
		
		private var dist:Number = 0;
		private var delta_x:Number;
		private var delta_y:Number;
		private var error:Point = new Point();
		private var newpt:Point = new Point();
		private var oldpt:Point
		private var preEdit:Vector3D = new Vector3D();
		private var lnkpts:Array = [];
		private var _floorType:Boolean = false;

		private var nline:LineSet 
		private var location:Point;

		private var touch:Touch = new Touch(1);
		public static var projDist:Number = 1000;
		private var _isInsert:Boolean = false;
		public var type:int = 0;
		public var lstSelectedpt:int = -1;
		public var Dindex:int = -1
		public static var ActiveBezier:BezierCurve;

		
		//I think fixing the artifact is an interesting problem, I wonder if you want
		// to maintain its absolute distance from its preceding point, or do you want to maintain
		// the percentage, so that if it's halfway it stays halfway between the points. hmm 
		//I think if you wanted to keep the artifact still, it'd be keeping its distance from the bezier
		//and you could do that by....... asking for its offset distance before you moved
		//it then plugging in its position by continuously just saying the artifact is at 
		//that offset from the point
		
		private var insrtPlace:uint;
		/** go to bezier add a point to insert a point hold alt
		 * **/
		public function BezierCurve () {  
			
			bezier = EditKeyHandler.BEZIER
			// ill probably kill this, since we'll let the camera or whatever NSprite follow one of these
			// remember all this is is a visual representation of the data so having all these distracting points actually helps
			
			// since none of them will ever appear in the game and if i control the segments i control the data
			// in other words i wont need greensock either whats important is progress, also this is only when its not "following" sonic
			
			// u determine this in an array
			//since this is visual you might wanna put a little slider and text over the middle take max height lowest and just place it there
			_step = 1/curvePoints
			
			
			
			 
			// and the initial points here as well they should pop up once the initi
			// we'll call you from edit key handler
			addEventListener(Event.ADDED_TO_STAGE, loaded);
			
			
			//_NSprite.addEventListener(Event.ENTER_FRAME, NSpriteLoop, false, 0, true);  
		}  
		
		protected function loaded(event:Event):void
		{
			stage.addEventListener(TouchEvent.TOUCH, touchEvent);
			_line = new LineSet(Main.liveCamera)
			nline = new LineSet(Main.liveCamera)
		}
		
		private function drawPoint (s:NSprite, color:uint=0xFF1100):void
		{
			
			// interesting why did i put it at that random position
		//	throw Error("why cant you draw")
			var imge:Image = new Image(Assets.getTexture("Circle"));
			imge.x -= 27;
			imge.y -= 30;
			imge.scaleX = 4
			imge.scaleY = 4
			s.addChild(imge);
			s.alignPivot("center","center")
//			p = new Shape
//			s.graphics.lineStyle(1,color);
//			s.graphics.beginFill(color)
//			s.graphics.drawCircle(0,0, 12);
			
			
		}
		public function drawCurve ():void {  
			grabPoints();
			
			// while were drawing we listen for an escape key
			if (EditKeyHandler.Esc)
			{
				// we also have to stop it from drawing
				// because if we regester more than one escape it wont work
				//this is supposed to handle the escape trigger if you do it once but your still in the escape blah blah
				
				
				
				
				
				
			}
			if(touch &&touch.phase == TouchPhase.MOVED){
			if(EditKeyHandler.shift){
				newpt.x = EditKeyHandler.location.x;
				newpt.y = EditKeyHandler.location.y;
				draging();
			}else{
				if(drag){
					if(oldpt){
					oldpt.x = newpt.x
					oldpt.y = newpt.y
					}else{
						oldpt = new Point()
						oldpt.x = EditKeyHandler.location.x;
						oldpt.y = EditKeyHandler.location.y
					}
					newpt.x = EditKeyHandler.location.x;
					newpt.y = EditKeyHandler.location.y;
					
					delta_x = (newpt.x - oldpt.x);
					delta_y = (newpt.y - oldpt.y);
					var olds:Object = {X:s.X,Y:s.Y,Z:s.Z}
					s.x += delta_x
					s.y += delta_y
					var unp:Vector3D = MainSceneMotor.Unproject(new Vector3D(s.x,s.y,s.zp))
					s.X = unp.x
					s.Y = unp.y
					s.Z = unp.z
						
					var delta:Vector3D = new Vector3D(s.X - olds.X, s.Y - olds.Y,s.Z - olds.Z)
					if(!EditKeyHandler.cntrl){
						for (var i3:int = 2; i3 < bezierPts.length; i3++) 
						{
							if(s == bezierPts[i3]){
								lstSelectedpt = i3
								//trace(lstSelectedpt, "at this point last selected point is...")
								
								var st:Object = bCntrlPts[2*i3]
								
								st.X += delta.x
								st.Y += delta.y
								st.Z += delta.z
								
								
								st = bCntrlPts[2*i3+1]
								
								st.X += delta.x
								st.Y += delta.y
								st.Z += delta.z
								if(lnkpts.length < 1)
									lnkpts.push(bCntrlPts[2*i3],bCntrlPts[2*i3+1])
								break;
							}
						}
						if(i3 < bCntrlPts.length - 1){
							for (var i4:int = 0; i4 < bCntrlPts.length; i4++) 
							{
								
								if(s == bCntrlPts[i4]){
									
									if(i4%2==0){
										lstSelectedpt = i4/2
											
										st = bCntrlPts[i4+1]
										
										st.X += delta.x
										st.Y += delta.y
										st.Z += delta.z
											
										
										st =bezierPts[i4/2]
											
										st.X += delta.x
										st.Y += delta.y
										st.Z += delta.z
											
										if(lnkpts.length < 1)
											lnkpts.push(bCntrlPts[i4+1],bezierPts[i4/2])
										break;
										
									}else{
										lstSelectedpt = (i4-1)/2
											
										st = bCntrlPts[i4-1]
//										
										st.X += delta.x
										st.Y += delta.y
										st.Z += delta.z
											
										
										st = bezierPts[(i4-1)/2]
										
										st.X += delta.x
										st.Y += delta.y
										st.Z += delta.z
											
										if(lnkpts.length < 1)
											lnkpts.push(bCntrlPts[i4-1],bezierPts[(i4-1)/2])
										break;
									}
								}
								
								
							}
						}
					}
				}
				shiftDragging = false
			}
			}
			dist = 0;
//			pp.projectionCenter = new Point(MainSceneMotor.vpX,MainSceneMotor.vpY);
//			pp.focalLength = MainSceneMotor.fl/1.7;
//			transform.perspectiveProjection = pp;
			//line2Anchor(s,_point1,_control1);
			//line2Anchor(s,_point2,_control2);
			
			curve[i2] = [];
			_line.removeAllSegments()
			 
			v.x = bezierPts[0].X; 
			v.y = bezierPts[0].Y; 
			v.z = bezierPts[0].Z;
			
			//p = MainSceneMotor.local3DToGlobal(v)
			
			//			throw Error("jkh ")
			v.x = _control1.X; 
			v.y = _control1.Y; 
			v.z = _control1.Z; 
			//p = MainSceneMotor.local3DToGlobal(v)
				
			_line.addSegment(new Vector3D(bezierPts[0].X,bezierPts[0].Y,bezierPts[0].Z), new Vector3D(_control1.X,_control1.Y,_control1.Z),0xFF9900);		

			
			
			
			v.x = bezierPts[1].X; 
			v.y = bezierPts[1].Y; 
			v.z = bezierPts[1].Z; 
//			p = MainSceneMotor.local3DToGlobal(v)
//			_line.graphics.moveTo(p.x, p.y);
			v2.x = _control2.X; 
			v2.y = _control2.Y; 
			v2.z = _control2.Z; 
			_line.addSegment(v,v2,Color.WHITE);		

			//			_line.graphics.moveTo(bezierPts[1].x, bezierPts[1].y);
			//			_line.graphics.lineTo(_control2.x, _control2.y);
			
			v.x = bezierPts[1].X; 
			v.y = bezierPts[1].Y; 
			v.z = bezierPts[1].Z; 
//			p = MainSceneMotor.local3DToGlobal(v)
//			_line.graphics.moveTo(p.x, p.y);
			v2.x = bCntrlPts[3].X; 
			v2.y = bCntrlPts[3].Y; 
			v2.z = bCntrlPts[3].Z; 
		
			_line.addSegment(v,v2,0xFF9900);		

			//_line.graphics.moveTo(bezierPts[1].x, bezierPts[1].y);
			//_line.graphics.lineTo(bCntrlPts[3].x, bCntrlPts[3].y);
			
			for (var k:int = 2; k < bezierPts.length; k++) 
			{
				v.x = bezierPts[k].X; 
				v.y = bezierPts[k].Y; 
				v.z = bezierPts[k].Z; 
//				p = MainSceneMotor.local3DToGlobal(v)
//				_line.graphics.moveTo(p.x, p.y);
				
				
				v2.x = bCntrlPts[2*k].X; 
				v2.y = bCntrlPts[2*k].Y; 
				v2.z = bCntrlPts[2*k].Z; 
//				p = MainSceneMotor.local3DToGlobal(v)
//				if(v.z > Camera.Z - 50)
//				_line.graphics.lineTo(p.x,p.y);
				
				_line.addSegment(v,v2,0xFF9900);		

				//_line.graphics.moveTo(bezierPts[k].x, bezierPts[k].y);
				//_line.graphics.lineTo(bCntrlPts[2*k].x, bCntrlPts[2*k].y);
				
				v.x = bezierPts[k].X; 
				v.y = bezierPts[k].Y; 
				v.z = bezierPts[k].Z; 
				
				v2.x = bCntrlPts[2*k+1].X; 
				v2.y = bCntrlPts[2*k+1].Y; 
				v2.z = bCntrlPts[2*k+1].Z; 
				
				_line.addSegment(v,v2,0xFF9900);		

				//				_line.graphics.moveTo(bezierPts[k].x, bezierPts[k].y);
				//				_line.graphics.lineTo(bCntrlPts[2*k+1].x, bCntrlPts[2*k+1].y);
				
			}
			
			
			
			//_line.graphics.lineStyle(1, 0xFFFFFF);
			//_line.graphics.moveTo(bezierPts[0].x, bezierPts[0].y);
			
			//should expand later to use multiple steps
			// this is temp code that ill integrate more completely later
			
			
			// i took the var outta this
			// these need to be combined eventually.. yeah seriously before it gets too complex
			tu = -1;
			for (u = 0; u <= 1; u += _step) { 
				tu++
					v.x = (1-u)*(1-u)*(1-u)*bezierPts[0].X+3*(1-u)*(1-u)*u*_control1.X+3*(1-u)*u*u*_control2.X+(u*u*u)*bezierPts[1].X;
				v.y = (1-u)*(1-u)*(1-u)*bezierPts[0].Y+3*(1-u)*(1-u)*u*_control1.Y+3*(1-u)*u*u*_control2.Y+(u*u*u)*bezierPts[1].Y;
				v.z = (1-u)*(1-u)*(1-u)*bezierPts[0].Z+3*(1-u)*(1-u)*u*_control1.Z+3*(1-u)*u*u*_control2.Z+(u*u*u)*bezierPts[1].Z;
				//ill wanna use my own transformation thingy or i could just get it from the point method i made i dunno yet
				p = local3DToGlobal(v);
				//lo
				if(u == 0){
					
					if(floorType){
						curve[0].push({X:0,Y:v.y,Z:v.z,D:0});
						tu++
					}else{
						curve[0].push({X:v.x,Y:v.y,Z:v.z,D:0});
						continue
					}
				}
				dist+=Math.sqrt((v.x - curve[0][tu-1].X)*(v.x - curve[0][tu-1].X)+(v.z - curve[0][tu-1].Z)*(v.z - curve[0][tu-1].Z))
				
				
				//_line.graphics.lineTo(p.x,p.y);
				
				// this is in\sanely wastefull
				curve[0].push({X:v.x,Y:v.y,Z:v.z,D:dist});
			} 
			
			// ph this makes sure lines and points arent drawn to this
			for (var j:int = 2; j < bezierPts.length; j++) 
			{
				// not only does it make sure they arent connected its a bit of clever code too
				// it makes multiple bezier curves, curve[i2], so you can just take it and draw lines to all the points
				//				if(j == segs[i2]){
				//					dist = 0;
				//					i2++
				//					continue;	
				//				}
				// if you wanna change it so that its different for every u youd have to change _step to some array of steps, where it has [J-1] in it
				var tu:int = curve[0].length -2;
				for (var u:Number = 0; u <= 1; u += _step) { 
					tu++
					v.x = (1-u)*(1-u)*(1-u)*bezierPts[j-1].X+3*(1-u)*(1-u)*u*bCntrlPts[2*j-1].X+3*(1-u)*u*u*bCntrlPts[2*j].X+(u*u*u)*bezierPts[j].X;
					v.y = (1-u)*(1-u)*(1-u)*bezierPts[j-1].Y+3*(1-u)*(1-u)*u*bCntrlPts[2*j-1].Y+3*(1-u)*u*u*bCntrlPts[2*j].Y+(u*u*u)*bezierPts[j].Y;
					v.z = (1-u)*(1-u)*(1-u)*bezierPts[j-1].Z+3*(1-u)*(1-u)*u*bCntrlPts[2*j-1].Z+3*(1-u)*u*u*bCntrlPts[2*j].Z+(u*u*u)*bezierPts[j].Z;
					//ill wanna use my own transformation thingy or i could just get it from the point method i made i dunno yet
					//					p = local3DToGlobal(v);
					//					_line.graphics.lineTo(p.x,p.y);
					//this is insanely wastefull
					
					if(u > 0){
						dist+=Math.sqrt((v.x - curve[i2][tu-1].X)*(v.x - curve[i2][tu-1].X)+(v.z - curve[i2][tu-1].Z)*(v.z - curve[0][tu-1].Z))
						
						
						curve[i2].push({X:v.x,Y:v.y,Z:v.z,D:dist});
					}
				} 
				
			}
			
//			_line.graphics.beginFill(0xFFFFFF);  
			
			
			
			
			for (var i:int = 0; i < curve.length; i++) {
				// this bit will be a tad complicated
				// we'll have to go through withought dynamic scaling for a bit 
				// and put it on last just use my local to global and draw the circlces small for now
				//				v.x = curve[][i].X
				//				v.y = curve[i].Y
				//				v.z = curve[i].Z
				//ill wanna use my own transformation thingy or i could just get it from the point method i made i dunno yet
				//p = local3DToGlobal(v);
				
				
				//throw Error("ds")
				//_line.graphics.drawCircle(p.x,p.y, 1);  
			}  
			
			
			//
			for (k = 2; k < bezierPts.length; k++) 
			{
				 
				
				
//			bezierPts[k].z = bezierPts[k].Z - Camera.Z
//				
//				
//				
//			
//			bCntrlPts[2*k].z = bCntrlPts[2*k].Z - Camera.Z
//			bCntrlPts[2*k+1].z = bCntrlPts[2*k+1].Z - Camera.Z
				//				bCntrlPts[2*k].x = p.x; 
				//				bCntrlPts[2*k].y = p.y; 
				//				bCntrlPts[2*k].z = 0; 
			}
			
		}  
		public function deleteline():void{
			nline.removeAllSegments()
			_line.removeAllSegments()
		}
		public function updateBez():void
		{
			// just first check if lineNSprites.length - 1 = the amount of lines we have if not then we need to add another one note it may need a check like if there are no points added yet we dont necessarily need to make another NSprite but it really shouldnt be a big deal it should be just chilling htere which is perfectly fine
			
			// eventually we need one that uses the crazy method for swapping depth because of the z, but for now forget it
			while(lineNSprites.length < curve.length) 
			{
				lineNSprites.push(new NSprite)
				
				addChildAt(lineNSprites[lineNSprites.length - 1],0);
				
			}
			if(_control2){
			_control1.Update()
			_control2.Update()
			}
			for (var i:int = 0; i < bCntrlPts.length; i++) 
			{
				bCntrlPts[i].Update()
			}
			for (i = 0; i < bezierPts.length; i++) 
			{
				bezierPts[i].Update()
				
			}
			nline.removeAllSegments()
		
			// we only have one lineNSprite we put this here when i wanted to expand this 
			for (var k:int = 0; k < lineNSprites.length; k++) 
			{
				
				
				for (var j:int = 1; j < curve[k].length; j++) 
				{
//					if(curve[k][j].Z > Camera.Z - 50){
					// umm once you have this down you might wanna reconsider making an object out of all of em dividing em into three and putting em into a single array seems but for now whatever
					v.x = curve[k][j-1].X
					v.y = curve[k][j-1].Y
					v.z = curve[k][j-1].Z
					
					v2.x = curve[k][j].X
					v2.y = curve[k][j].Y
					v2.z = curve[k][j].Z
					//ill wanna use my own transformation thingy or i could just get it from the point method i made i dunno yet
					//p = MainSceneMotor.local3DToGlobal(v);
					if(false){
						
					}else{
						
						
						nline.addSegment(v,v2,Color.WHITE);		

//						lineNSprites[k].graphics.lineTo(p.x,p.y);
//						lineNSprites[k].graphics.drawCircle(p.x,p.y, 2*MainSceneMotor.fl/(MainSceneMotor.fl +v.z));
					}
				//	}
				}
			}
			
			
		}
		
		private function draging():void
		{
			if(!shiftDragging){
				newY = location.y;
				shiftDragging = true;
			}
			if(drag)
			{
				// this works kinda.. it doesnt push away
				oldY = newY;
				newY = location.y;
				deltaY = newY - oldY;
				//s.startDrag(true);
				var olds:Object = {X:s.X,Y:s.Y,Z:s.Z}
				
				s.zp -= deltaY
				var unp:Vector3D = MainSceneMotor.Unproject(new Vector3D(s.x,s.y,s.zp))
				s.X = unp.x
				s.Y = unp.y
				s.Z = unp.z
					
				var delta:Vector3D = new Vector3D(s.X - olds.X, s.Y - olds.Y,s.Z - olds.Z)

				if(!EditKeyHandler.cntrl){
					
					// this is such an embarissingly stupid solution... uggggghhhhghghghghggh
					for (var i3:int = 2; i3 < bezierPts.length; i3++) 
					{
						if(s == bezierPts[i3]){
							lstSelectedpt = i3
							//trace(lstSelectedpt, "at this point last selected point is...")
							//bCntrlPts[2*i3].z -= deltaY
							var st:Object = bCntrlPts[2*i3]
							
							st.X += delta.x
							st.Y += delta.y
							st.Z += delta.z
							
								st = bCntrlPts[2*i3+1]
							
								st.X += delta.x
								st.Y += delta.y
								st.Z += delta.z
									
							if(lnkpts.length < 1)
								lnkpts.push(bCntrlPts[2*i3],bCntrlPts[2*i3+1])
							break;
						}
						
					}
					// I DONT KNOW WHAT THISSS MEEEANNNANANANSSSS haha ok I get this it just moves all of em relative to whether if its the cntrl point hmm
					if(i3 < bCntrlPts.length - 1){
						for (var i4:int = 0; i4 < bCntrlPts.length; i4++) 
						{
							
							if(s == bCntrlPts[i4]){
								
								if(i4%2==0){
									st = bCntrlPts[i4+1]
									
									st.X += delta.x
									st.Y += delta.y
									st.Z += delta.z
										
									st = bezierPts[i4/2]
									
									st.X += delta.x
									st.Y += delta.y
									st.Z += delta.z
										
									if(lnkpts.length < 1)
										lnkpts.push(bCntrlPts[i4+1],bezierPts[i4/2])
									break;
									
								}else{
									
									st = bCntrlPts[i4-1]
									
									st.X += delta.x
									st.Y += delta.y
									st.Z += delta.z
																		
									st = bezierPts[(i4-1)/2]
									
									st.X += delta.x
									st.Y += delta.y
									st.Z += delta.z
										
									if(lnkpts.length < 1)
										lnkpts.push(bCntrlPts[i4-1],bezierPts[(i4-1)/2])
									break;
								}
							}
						}
						
					}
				}
				
				
			}
		}
		
		private function line2Anchor(s:NSprite,p1:NSprite, p2:NSprite):void
		{
			
		}
		
		private function grabPoints ():void {  
			//				cy = t1s * _point1.y + tt12 * _control.y + ts * _point2.y;  
			
			//				  
			//				t += 1/_curvePoints;  
			//			}  
			//			
			//			var last:int = _curve.length-1;  
			//			var prev:int = _curve.length-2;  
			//			
			//			// i dont think i need this
			//			angle = Math.atan2(_curve[last].y - _curve[prev].y, _curve[last].x - _curve[prev].x);  
			//			
		}  
		
		private function touchEvent(event : TouchEvent) : void
		{
			touch= event.getTouch(event.target as DisplayObject);
			
				
				if(touch){
				location = touch.getLocation(this);
				if(touch.phase == TouchPhase.BEGAN)// ||touch.phase == TouchPhase.MOVED)
					MouseDown(event)
					
				if(touch.phase == TouchPhase.ENDED)
					onPointUp(event)
					
				}
		}
		
		
		
		// this is kinda gross this should not be run here i can get a reference from the main editkeyhandler
		//i deeply dislike event listeners and this could potentially make dozens of them
		
		//(TODO:JON)fix this garbage, it should be fine while i only have just one soyeah not a big deal now but will be later 
		
		// hopefully i shouldnt need the this == thing because if its added to stage it should be the only one
		protected function MouseDown(event:TouchEvent):void
		{				
				if(this == EditKeyHandler.bezTool){
				var t:Object = hitTest(location);  
//				if(!(s is NSprite))
//					return
				if(t)
				s = t.parent as NSprite
				else
				s = null
				// were adding way too many event listeners and thats dumb
				
				
				if(s){
					// its better to do it like this handling multiple states
					// we should look for focus too but i think it maybe cleaner to just not listen to event listeners during that
					
					drag = true;
					preEdit.x = s.X;
					preEdit.y = s.Y;
					preEdit.z = s.Z;
					
					error.x = 0//location.x - s.x;
					error.y = 0//location.x - s.x;
					newpt = location
					_update = true;  
					_animate = false;
					if(EditKeyHandler.shift){
						newY = location.y	
					}
					
					
				}else if((EditKeyHandler.State == bezier && !isInsert)){
					lstSelectedpt = -1

					// obviously you wanna see if shift is down or whatever i really dont know
					bezierPts.push(new NSprite());
					if(EditKeyHandler.shift){
						// its a bit cool it says if shift we project to same distance that sonic is away from the camera there is a rererence to projEist in EditkeyHandler
					var st:Vector3D = MainSceneMotor.Unproject(new Vector3D(location.x,location.y,projDist))
					}else{
					st = MainSceneMotor.Unproject(new Vector3D(location.x,location.y,1000))
	// i think i wannna start from a developing standpoint? in that i wanna see the thing up in a bezier and manually before i use the mouse pointing shit in now that im looking at it i wouldnt be surprised if it took all day but who knows ive beeen wrong before
					}
					bezierPts[bezierPts.length-1].X = st.x
					bezierPts[bezierPts.length-1].Y = st.y
					bezierPts[bezierPts.length-1].Z = st.z
					
					// and some random z based of focal length
					////trace("my cam ", Camera.Z)
					drawPoint(bezierPts[bezierPts.length-1]); 
					addChild(bezierPts[bezierPts.length-1]); 
					
					
					if(bezierPts.length == 2)
					{
						// a more advanced thing is you wanna do this but add a step count later to it
						bCntrlPts.push(new NSprite());
						bCntrlPts.push(new NSprite());
						bCntrlPts.push(new NSprite());
						bCntrlPts.push(new NSprite());
						drawPoint(_point1);  
						_control2 =  new NSprite()
						drawPoint(_control1, 0xFF9900);  
						drawPoint(_control2, 0xFF9900);  
						drawPoint(bCntrlPts[3], 0xFF9900);  
						// this is where you start everything and add the event listener
						
						
						
					
						_control1.X = bCntrlPts[0].X = bCntrlPts[1].X = bezierPts[0].X;
						_control1.Y = bCntrlPts[0].Y = bCntrlPts[1].Y = bezierPts[0].Y;
						_control1.Z = bCntrlPts[0].Z = bCntrlPts[1].Z = bezierPts[0].Z;
						
						_control2.X = bCntrlPts[2].X = bCntrlPts[3].X = bezierPts[1].X;
						_control2.Y = bCntrlPts[2].Y = bCntrlPts[3].Y = bezierPts[1].Y;
						_control2.Z = bCntrlPts[2].Z = bCntrlPts[3].Z = bezierPts[1].Z;
						
//						_control2.x = bCntrlPts[2].x = bezierPts[1].x;  
//						_control2.y = bCntrlPts[2].y = bezierPts[1].y;
//						_control2.Z = bCntrlPts[2].Z = bezierPts[1].Z;
//						
//						bCntrlPts[3].x = bezierPts[1].x;
//						bCntrlPts[3].y = bezierPts[1].y;
//						bCntrlPts[3].Z = bezierPts[1].Z;
						
						addChild(_control1);  
						addChild(_control2);
						addChild(bCntrlPts[3]);
						addChild(_NSprite);  
						
						drawCurve();  
						
						
						isUpdate = true;
					}else if(bezierPts.length > 2)
					{
						// I'd like some reorganization to make this a bit more readable since it does a few things repeatedly 
						bCntrlPts.push(new NSprite());
						
						drawPoint(bCntrlPts[bCntrlPts.length -1], 0xFF9900); 
						
						bCntrlPts[bCntrlPts.length -1].X = bezierPts[bezierPts.length-1].X;
						bCntrlPts[bCntrlPts.length -1].Y = bezierPts[bezierPts.length-1].Y;
						bCntrlPts[bCntrlPts.length -1].Z = bezierPts[bezierPts.length-1].Z;
						
						addChild(bCntrlPts[bCntrlPts.length -1]);
						
						bCntrlPts.push(new NSprite());
						
						drawPoint(bCntrlPts[bCntrlPts.length -1], 0xFF9900); 
						
						bCntrlPts[bCntrlPts.length -1].X = bezierPts[bezierPts.length-1].X;
						bCntrlPts[bCntrlPts.length -1].Y = bezierPts[bezierPts.length-1].Y;
						bCntrlPts[bCntrlPts.length -1].Z = bezierPts[bezierPts.length-1].Z;
						
						addChild(bCntrlPts[bCntrlPts.length -1]);
						
						
						drawCurve(); 
					}
					
					updateBez();
				}else if((EditKeyHandler.State == bezier && isInsert &&bezierPts.length >= 2)){
					
					
					//ITS ALT CLICK TO DO IT WHILE IN BEZIER MODE
					
					// we'll do a simple insert nothing special just find its nearest neighbor and put it ahead of its place
					// we could add tracking after wards like hold down a button then left to right tracks it up through the chain
					// thats both really simple and very effective
					// its a really just stupidly simple solution but it works so i dont care too much
					// this limit isnt very clever but should work in most cases, but will break if the distance exceeds this
					if(EditKeyHandler.shift)
						st = MainSceneMotor.Unproject(new Vector3D(location.x,location.y,projDist))
					else
						st = MainSceneMotor.Unproject(new Vector3D(location.x,location.y,1000))
					
					var lowestAngle:Number = 999999999999999999999999
					for (var i:int = 0; i < bezierPts.length-1; i++) 
					{
						
					var h:NSprite = bezierPts[i]
					var h2:NSprite = bezierPts[i+1]
					var angDa:Number = angDiff(anglepts(h,h2,false),anglepts(h,location,false))
					var angDb:Number = angDiff(anglepts(h2,h,false),anglepts(h2,location,false))
					var ttlAngToSonic:Number = angDa+angDb
						
					var ptt:Vector3D = MainSceneMotor.project(new Vector3D(h.X,h.Y,h.Z))
					  if(ttlAngToSonic < lowestAngle && ptt.z > 0){
						lowestAngle = ttlAngToSonic
						insrtPlace = i+1
					  }
						
					}	
					
					bezierPts.splice(insrtPlace,0,new NSprite());
					// at this point we went through and got the lowest distance that was ahead of the camera
					// TODO:: IMPORTANT ADD DEFAULT pointDepth  variable instead of 300 1000, is a good distance too projDist should be changed to sonicsCurDepth or something also
					

					bezierPts[insrtPlace].X = st.x
					bezierPts[insrtPlace].Y = st.y
					bezierPts[insrtPlace].Z = st.z
					
					// and some random z based of focal length
					drawPoint(bezierPts[insrtPlace]); 
					addChild(bezierPts[insrtPlace]); 
					// this is where i copied and pasted ***blows rasberries 
					// a lil oop action would of worked wonders here, oh well, I may change it to oop because bezierCurves are just way too usefull to leave as is, and 
					// I'd like some reorganization to make this a bit more readable since it does a few things repeatedly 
					bCntrlPts.splice(insrtPlace*2,0, new NSprite());
					bCntrlPts.splice(insrtPlace*2,0,new NSprite());
					
					drawPoint(bCntrlPts[insrtPlace*2], 0xFF9900); 
					addChild(bCntrlPts[insrtPlace*2]);
					
					drawPoint(bCntrlPts[insrtPlace*2+1], 0xFF9900); 
					addChild(bCntrlPts[insrtPlace*2+1]);
					
					bCntrlPts[insrtPlace*2].X = bCntrlPts[insrtPlace*2+1].X = bezierPts[insrtPlace].X;
					bCntrlPts[insrtPlace*2].Y = bCntrlPts[insrtPlace*2+1].Y = bezierPts[insrtPlace].Y;
					bCntrlPts[insrtPlace*2].Z = bCntrlPts[insrtPlace*2+1].Z = bezierPts[insrtPlace].Z;
					var lpt:int = insrtPlace 
						
				
					drawCurve(); 
				}
			}
		}
		//this may come in useful for other shit it measures the distance betweeen two angles and then tells you if its signed or unsigned
		public function angDiff(alpha:Number,beta:Number, signed:Boolean =false):Number {
			var  phi:Number = Math.abs(beta - alpha) % (2*Math.PI);       // This is either the distance or 360 - distance
			var distance:Number = phi > Math.PI ? (2*Math.PI) - phi : phi;
			if(!signed){
			return distance;
			}else{
				var sign:Number = (alpha - beta >= 0 && alpha - beta <= 180) || (alpha - beta <=-180 && alpha- beta>= -360) ? 1 : -1; 
				return distance*= sign;
			}
		}
		
		/** the points require having an x and a y this is different than the one in mainScene motor**/
		public function anglepts(point1:Object, point2:Object,inDegrees:Boolean = true):Number
		{
			var dy:Number = point2.y - point1.y ;
			var dx:Number = point2.x - point1.x;
			if(inDegrees)
				return Math.atan2(dy, dx)* 180/Math.PI
			else
				return Math.atan2(dy, dx)
		}
		// Dont work dont know why really
		public function DeletePt():void
		{
			//trace("the last selected point was ",lstSelectedpt)
			if(bezierPts.length > 2 && lstSelectedpt >=2){
			
				removeChild(bezierPts[lstSelectedpt])
				bezierPts.splice(lstSelectedpt)
				removeChild(bCntrlPts[2*lstSelectedpt])
				bCntrlPts.slice(2*lstSelectedpt)
				removeChild(bCntrlPts[2*lstSelectedpt+1])
				bCntrlPts.splice(2*lstSelectedpt+1)
				
				drawCurve();
				
			}
			lstSelectedpt = -1
		}
		
		public function onPointDown (x:Number, y:Number, z:Number):void {  
			
			if(EditKeyHandler.State == bezier){
				//s.startDrag(true);  
				_update = true;  
				_animate = false;
			} else{
				// obviously you wanna see if shift is down or whatever i really dont know
				bezierPts.push(new NSprite());
				// i was so what i did was just replace the drawing api so it draws using opengl, but my own implementation of the line drawing
				// I thought it may be necessary because the coordinates seemed to be wrong because it was upside down, but still worked, i suspect its because of the RH that i was using, or left hand im not really to sure but yeah
				// so to test we need to see if the thing actually draws a line and whatnot, I didnt change anything else in here, I dont forsee a need of having more than having more than one active line at a time but i may leave a line rendered which wouldnt be difficult ill just say draw a line between the set of points wherever its not a bezier
				// If i need it that is 
				
				
				// so just running this and getting things ready has us all set for whats next, and that is, first pushing in the hornets and getting them in the scene
				// then getting a fight set up for hornets, also we need to set up and tweek the values of everything physics wise and what not , also change hornets so they are never on the path i can always tell where they are on the path for now, whether they are past sonic on the x/ z later 
				// we'll create a rotation to path parameter and use the dot product to find its distance to whether its passed sonic or not
				// this is all set up to a new level of interaction in fighting... essentially im trying to do what was left behind, what carmack couldn't 
				
				
				// what that would take would be an unprecidented level of synergy between the code and the animation
				// speaking of which i need to implement looped live editing, we'll just pop sonic and the baddes back to the beginning and give him the same input
				
				
				// just pop the hero and friends back to a certain loc in time  with a button press and frame of animation and states for the actors
				
				// so at first real simple which will be great is just move em back , and just add a todo later if i need it, i can literally change that shit in code so it really doesnt matter that much
				
				
				// we really cant cheat that
				// let me push A COLLECTION OF IFS on frame if i dont already.. its interesting because on closer inspection this is a bit of a harder problem then initially thought, because we want to know where if the frame that the frame comes in is it local global, and what is it relative to, and how do we change and move it throughout the system without losing my mind, and keeping modality, Im thinking ill have to keep that in mind to begin with, and make those decisions on the fly, so I say something lke relative to group, relative to seed, fixed... ok lets get this show started
				
				
				// so i set up shift 2 and the 
				
				// I trust all thats left is to go about just checking and seeing if they actually work i think who knows honestly .. oh then tweeking let me see what that code for jumping is 
				
				// so mission for today is just skeleton the first and pop back and the second ifs seed, were not gonna do any code to define seeds or anything we'll figure that out on the go, its a bit hard to see how thats going to come together
				// and then were gonna test ititititititititi, the new bezier and the Level editor frame write out
				
				// and then finally we'll do the drudge of getting everything in working order YAAHAYAYAYAYAYAYAYAHAHAHAYAYAYAAYAYAYAYAAAA!!!
				
				// try mathless first so its very specific instruction, like hornet here here here, and introduce math, like this point relative to sonic then relative to the hornet.. then after that, we can introduce some more arbritrary loc, then linear blend , to try and catch a seed patch, we can go from large to small, then we can keep trying to get the different seed patch that way,keep breaking it down, to make   math like sines and cosines, to try to catch one o i think i would try from three seperate seeds, create each of their own variations, and then after that, try a death seeds, and we run through this every death
				// but thats just a plan if it doesnt work really play, this is the most important game/animation feature, we have to get this right so spend as much time as you need with this prototyping, even if this all gets thrown out that's still alright
				
				
				
				
				
				// then we can work on each bits of animation and its the variety from the points that we'd be interested in, not necessarily the same thing
				// but since we have the interactive coding spot itd help us immensely 
				
				// so after we get the rough working how i want it then we have to lock down the hornet design  when we do it for real
				
				// while I change the parameters on the hornets and parameters while its in that scene, I can pop it out if need be
				// but itll just have one automatic is if on frame if greater than frame, which means each hornet needs its own layer
				// then we need one for the overal group behaviour 
				bezierPts[bezierPts.length-1].x = x
				bezierPts[bezierPts.length-1].y = y;
				bezierPts[bezierPts.length-1].Z =z//bezierPts[bezierPts.length-2].Z// Camera.Z + 100;
				// and some random z based of focal length
				
				drawPoint(bezierPts[bezierPts.length-1]); 
				addChild(bezierPts[bezierPts.length-1]);
				
				//stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown, false, 0, true);
				
			}
		}  
		
		
		
		private function onPointUp (event:TouchEvent):void {  
			
				
			// its a move and a click instruction set, so this is fine
			//, for inserting and deleting Ill have to do that else where
			if(drag){
				EditKeyHandler.undoList.push({inc:1,delta:{x:s.X -preEdit.x,y:s.Y - preEdit.y,z:s.Z -preEdit.z},point:s, pts:lnkpts, bez:this})
				lnkpts= [];
				// stopDrag()
			}else if(true){
				lpt = insrtPlace
				if(EditKeyHandler.State == bezier && isInsert){
				EditKeyHandler.undoList.push({inc:2, point:{x:bezierPts[lpt].X,y:bezierPts[lpt].Y,z:bezierPts[lpt].Z},cntrl1:{x:bCntrlPts[lpt*2].X,y:bCntrlPts[lpt*2].Y,z:bCntrlPts[lpt*2].Z},cntrl2:{x:bCntrlPts[lpt*2+1].X,y:bCntrlPts[lpt*2+1].Y,z:bCntrlPts[lpt*2+1].Z},insert:lpt, bez:this});
				
				}else if(EditKeyHandler.State ==  7){
				EditKeyHandler.undoList.push({inc:5, point:{x:bezierPts[lpt].X,y:bezierPts[lpt].Y,z:bezierPts[lpt].Z},cntrl1:{x:bCntrlPts[lpt*2].X,y:bCntrlPts[lpt*2].Y,z:bCntrlPts[lpt*2].Z},cntrl2:{x:bCntrlPts[lpt*2+1].X,y:bCntrlPts[lpt*2+1].Y,z:bCntrlPts[lpt*2+1].Z},insert:lpt, bez:this, val:Main.liveCamera.hero_mc.body.position.x,X:LevelEditor.awyCam.rotationX,Y:LevelEditor.awyCam.rotationY,Z:LevelEditor.awyCam.rotationZ});
					
				}
				
				// if this breaks it should be easy enough to fix probably on first creation honestly
				var lpt:int =  bezierPts.length -1
					
				if(lpt >=2){
				// its completely unnecessary to have anything besides the main point but 
				
				EditKeyHandler.undoList.push({inc:2, point:{x:bezierPts[lpt].X,y:bezierPts[lpt].Y,z:bezierPts[lpt].Z},cntrl1:{x:bCntrlPts[lpt*2].X,y:bCntrlPts[lpt*2].Y,z:bCntrlPts[lpt*2].Z},cntrl2:{x:bCntrlPts[lpt*2+1].X,y:bCntrlPts[lpt*2+1].Y,z:bCntrlPts[lpt*2+1].Z},insert:lpt, bez:this});
				}else{
					//just delete the thing so it actually works out weirdly enough except i need the control1 sprite quardenets and so on
				}
			
			}
			drag = false
			_update = false;  
			ActiveBezier = this
				//trace(lstSelectedpt)
		}  
		
		//update curve  
		public function onLoop ():void { 
			
			if (isUpdate) {  
				//throw Error();
				drawCurve();  
			} else {  
				//move NSprite!!!! 
				//				if (!_animate) {  
				//					linePath.points = _curve;  
				//					progress = 0;  
				//					a = 0.01;  
				//					linePath.snap(_NSprite);  
				//					_animate = true;  
				//				}
				
			}
			if(_update)
				updateBez();
			
			
		}  
		
		// NOT NEEDED AT ALL
		//move NSprite on the created curve  
		private function NSpriteLoop (event:Event = null):void {  
			//			if (_animate) {  
			//				progress += a;  
			//				if (progress <= 1) {  
			//					linePath.renderObjectAt(_NSprite, progress);  
			//					a += 0.005;  
			//				} else {  
			//					
			//					//grab final speed and angle (you may use initial speed of contact for exit speed)  
			//					_NSprite.x += linePath.totalLength*a*Math.cos(angle);  
			//					_NSprite.y += linePath.totalLength*a*Math.sin(angle);  
			//					
			//				}  
			
			//			}  
		}  
		
		public function CreateBez(ary:Array):void{
			
			if(!ary){
				return
			}
			for each (var a:Object in ary[0]) 
			{
				
				MakeBezierPt(a.X,a.Y,a.Z)
			}
			//trace(ary[1].length)
			_control1.X = ary[1][0].X
			_control1.Y = ary[1][0].Y;
			_control1.Z = ary[1][0].Z
			
			
			_control2.X = ary[1][1].X
			_control2.Y = ary[1][1].Y;
			_control2.Z = ary[1][1].Z;
			
			for (var i:int = 2; i < ary[1].length; i++) 
			{
				
				bCntrlPts[i-2].X = ary[1][i].X
				bCntrlPts[i-2].Y = ary[1][i].Y
				bCntrlPts[i-2].Z = ary[1][i].Z
			}
			
			
			
				
		}
		
		public function MakeBezierPt(bx:Number = 0,by:Number = 0, bz:Number = 0, isManual:Boolean = false, atIndex:int = -1):void
		{
			lstSelectedpt = -1
					
				if(atIndex == -1){
					atIndex = bezierPts.length
				}
				 if(EditKeyHandler.State == bezier ||EditKeyHandler.State ==  7){
					
					// obviously you wanna see if shift is down or whatever i really dont know
					//bezierPts.push(new NSprite());
					bezierPts.splice(atIndex,0,new NSprite())
					bezierPts[atIndex].X = bx;
					bezierPts[atIndex].Y = by;
					
					bezierPts[atIndex].Z = bz;
					// and some random z based of focal length
					
					drawPoint(bezierPts[atIndex]); 
					addChild(bezierPts[atIndex]); 
					
					
					if(bezierPts.length == 2)
					{
						// a more advanced thing is you wanna do this but add a step count later to it
						bCntrlPts.push(new NSprite());
						bCntrlPts.push(new NSprite());
						bCntrlPts.push(new NSprite());
						bCntrlPts.push(new NSprite());
						
						drawPoint(_point1);  
						
						drawPoint(_control1, 0xFF9900);  
						drawPoint(_control2, 0xFF9900);  
						drawPoint(bCntrlPts[3], 0xFF9900);  
						// this is where you start everything and add the event listener
						
						
						
						
						
						_control1.X = bCntrlPts[0].X = bCntrlPts[1].X = bezierPts[0].X;
						_control1.Y = bCntrlPts[0].Y = bCntrlPts[1].Y = bezierPts[0].Y;
						_control1.Z = bCntrlPts[0].Z = bCntrlPts[1].Z = bezierPts[0].Z;
						
						_control2.X = bCntrlPts[2].X = bCntrlPts[3].X = bezierPts[1].X;
						_control2.Y = bCntrlPts[2].Y = bCntrlPts[3].Y = bezierPts[1].Y;
						_control2.Z = bCntrlPts[2].Z = bCntrlPts[3].Z = bezierPts[1].Z;
						
						
						
						
						
						addChild(_control1);  
						addChild(_control2);
						addChild(bCntrlPts[3]);
						addChild(_NSprite);  
						
						drawCurve();  
						
						
						isUpdate = true;
					}else if(bezierPts.length > 2)
					{
						
						bCntrlPts.splice(atIndex*2,0,new NSprite());
						
						drawPoint(bCntrlPts[atIndex*2], 0xFF9900); 
						
						bCntrlPts[atIndex*2].X = bezierPts[atIndex].X;
						bCntrlPts[atIndex*2].Y = bezierPts[atIndex].Y;
						bCntrlPts[atIndex*2].Z = bezierPts[atIndex].Z;
						
						
						
						addChild(bCntrlPts[atIndex*2]);
						
						bCntrlPts.splice(atIndex*2+1,0,new NSprite());
						
						drawPoint(bCntrlPts[atIndex*2+1], 0xFF9900); 
						
						bCntrlPts[atIndex*2+1].X = bezierPts[atIndex].X;
						bCntrlPts[atIndex*2+1].Y = bezierPts[atIndex].Y;
						bCntrlPts[atIndex*2+1].Z = bezierPts[atIndex].Z;
						
						
						addChild(bCntrlPts[atIndex*2+1]);
						
						
						drawCurve(); 
					}
					
					updateBez();
				}
			if(isManual){
				EditKeyHandler.undoList.push({inc:2, bez:this});
			}
				 
			}
	
		public function MakeBezierPtOld(bx:Number = 0,by:Number = 0, bz:Number = 0, isManual:Boolean = false, atIndex:int = -1):void
		{
			lstSelectedpt = -1
			
			if(EditKeyHandler.State == bezier){
				
				// obviously you wanna see if shift is down or whatever i really dont know
				bezierPts.push(new NSprite());
				
				bezierPts[bezierPts.length-1].X = bx;
				bezierPts[bezierPts.length-1].Y = by;
				
				bezierPts[bezierPts.length-1].Z = bz;
				// and some random z based of focal length
				
				drawPoint(bezierPts[bezierPts.length-1]); 
				addChild(bezierPts[bezierPts.length-1]); 
				
				
				if(bezierPts.length == 2)
				{
					// a more advanced thing is you wanna do this but add a step count later to it
					bCntrlPts.push(new NSprite());
					bCntrlPts.push(new NSprite());
					bCntrlPts.push(new NSprite());
					bCntrlPts.push(new NSprite());
					
					drawPoint(_point1);  
					
					drawPoint(_control1, 0xFF9900);  
					drawPoint(_control2, 0xFF9900);  
					drawPoint(bCntrlPts[3], 0xFF9900);  
					// this is where you start everything and add the event listener
					
					
					
					
					
					_control1.X = bCntrlPts[0].X = bCntrlPts[1].X = bezierPts[0].X;
					_control1.Y = bCntrlPts[0].Y = bCntrlPts[1].Y = bezierPts[0].Y;
					_control1.Z = bCntrlPts[0].Z = bCntrlPts[1].Z = bezierPts[0].Z;
					
					_control2.X = bCntrlPts[2].X = bCntrlPts[3].X = bezierPts[1].X;
					_control2.Y = bCntrlPts[2].Y = bCntrlPts[3].Y = bezierPts[1].Y;
					_control2.Z = bCntrlPts[2].Z = bCntrlPts[3].Z = bezierPts[1].Z;
					
					
					
					
					
					addChild(_control1);  
					addChild(_control2);
					addChild(bCntrlPts[3]);
					addChild(_NSprite);  
					
					drawCurve();  
					
					
					isUpdate = true;
				}else if(bezierPts.length > 2)
				{
					
					bCntrlPts.push(new NSprite());
					
					drawPoint(bCntrlPts[bCntrlPts.length -1], 0xFF9900); 
					
					bCntrlPts[bCntrlPts.length -1].X = bezierPts[bezierPts.length-1].X;
					bCntrlPts[bCntrlPts.length -1].Y = bezierPts[bezierPts.length-1].Y;
					bCntrlPts[bCntrlPts.length -1].Z = bezierPts[bezierPts.length-1].Z;
					
					
					
					addChild(bCntrlPts[bCntrlPts.length -1]);
					
					bCntrlPts.push(new NSprite());
					
					drawPoint(bCntrlPts[bCntrlPts.length -1], 0xFF9900); 
					
					bCntrlPts[bCntrlPts.length -1].X = bezierPts[bezierPts.length-1].X;
					bCntrlPts[bCntrlPts.length -1].Y = bezierPts[bezierPts.length-1].Y;
					bCntrlPts[bCntrlPts.length -1].Z = bezierPts[bezierPts.length-1].Z;
					
					
					addChild(bCntrlPts[bCntrlPts.length -1]);
					
					
					drawCurve(); 
				}
				
				updateBez();
			}
			if(isManual){
				EditKeyHandler.undoList.push({inc:2, bez:this});
			}
			
		}
		
		public function get selectedBezier():Array
		{
			return _selectedBezier;
		}
		
		public function set selectedBezier(value:Array):void
		{
			_selectedBezier = value;
		}
		
		public function get bezierPts():Array
		{
			return _bezierPts;
		}
		
		public function set bezierPts(value:Array):void
		{
			_bezierPts = value;
		}
		
		public function get floorType():Boolean
		{
			return _floorType;
		}
		
		public function set floorType(value:Boolean):void
		{
			_floorType = value;
		}

		public function get isInsert():Boolean
		{
			return _isInsert;
		}

		public function set isInsert(value:Boolean):void
		{
			_isInsert = value;
		}

		public function get line():LineSet
		{
			return _line;
		}

		public function set line(value:LineSet):void
		{
			_line = value;
		}

		public function get curvePoints():int
		{
			return _curvePoints;
		}

		public function set curvePoints(value:int):void
		{
			_curvePoints = value;
		}
		
		
		
		
		
		
		
	}  
}  
