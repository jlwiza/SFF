package {  
	import com.greensock.motionPaths.LinePath2D;
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	
	import flash.display.NSprite;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import feathers.core.IFeathersControl;
	
	
	
	public class OldBezierCurve extends Sprite {  
		
		//public static  var curve:Array = [];  
		private var _point1:Sprite = new Sprite();  
		private var _point2:Sprite = new Sprite();  
		private var _control2:Sprite = new Sprite();   
		private var _line:Sprite = new Sprite();  
		private var _sprite:Sprite = new Sprite();  
		
		private var _update:Boolean = false;  
		private var _curvePoints:int = 5;  
		private var _step:Number
		private var _animate:Boolean = false;  
		
		private var linePath:LinePath2D;  
		private var angle:Number;  
		private var a:Number = 0.01;  
		private var progress:Number = 0;  
		public  var _control1:Sprite = new Sprite();
		private var v:Vector3D = new Vector3D();
		private var p:flash.geom.Point;
		private var CbezPts:Array = [];
		private var _bezierPts:Array = [];
		public  var bCntrlPts:Array = [];
		
		// i might put s from the outside in here when i make the circles we'll see
		public var Update:Boolean;
		public  var curve:Array = [];
		
		private var pp:PerspectiveProjection = new PerspectiveProjection();
		private var oldY:Number = 0;
		private var newY:Number = 0;
		private var deltaY:Number;
		public var drag:Boolean;
		
		private var s:Sprite;
		private var shiftDragging:Boolean = false;
		private var i2:int = 0;
		public static var segs:Array = [];
		private var lineSprites:Vector.<Sprite> = new Vector.<Sprite>();
		private var _selectedBezier:Array = [];
		private var bezier:int = 1;
		
		private var dist:Number = 0;
		private var delta_x:Number;
		private var delta_y:Number;
		private var error:Point = new Point();
		private var newpt:Point = new Point();
		private var oldpt:Point = new Point();
		private var preEdit:Vector3D = new Vector3D();
		private var lnkpts:Array = [];
		private var _floorType:Boolean = false;
		
		
		public function BezierCurve () {  
			
			bezier = EditKeyHandler.BEZIER
			// ill probably kill this, since we'll let the camera or whatever sprite follow one of these
			// remember all this is is a visual representation of the data so having all these distracting points actually helps
			
			// since none of them will ever appear in the game and if i control the segments i control the data
			// in other words i wont need greensock either whats important is progress, also this is only when its not "following" sonic
			
			// u determine this in an array
			//since this is visual you might wanna put a little slider and text over the middle take max height lowest and just place it there
			_step = 1/_curvePoints
			
			
			
			addChild(_line);  
			
			// and the initial points here as well they should pop up once the initi
			// we'll call you from edit key handler
			addEventListener(Event.ADDED_TO_STAGE, loaded);
			
			
			//_sprite.addEventListener(Event.ENTER_FRAME, spriteLoop, false, 0, true);  
		}  
		
		protected function loaded(event:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown, false, 0, true);
			
		}
		
		private function drawPoint (s:Sprite, color:uint=0xFF1100):void
		{
			s.graphics.lineStyle(1,color);
			s.graphics.beginFill(color)
			s.graphics.drawCircle(0,0, 6);
			
			
		}
		
		public function makeBez (ary:Array):void
		{
			for (var i:int = 0; i < ary.length-1; i++) 
			{
				
				bezierPts.push(new Sprite());
				
				bezierPts[i].x = ary[i].X
				bezierPts[i].y = ary[i].Y
				bezierPts[i].z = ary[i].Z
				
				
				
				// and some random z based of focal length
				
				drawPoint(bezierPts[i]); 
				addChild(bezierPts[i]); 
				//if(i != 0){
				bCntrlPts.push(new Sprite());
				
				drawPoint(bCntrlPts[i], 0xFF9900); 
				
				bCntrlPts[bCntrlPts.length -1].x = bezierPts[bezierPts.length-1].x;
				bCntrlPts[bCntrlPts.length -1].y = bezierPts[bezierPts.length-1].y;
				bCntrlPts[bCntrlPts.length -1].z = bezierPts[bezierPts.length-1].z;
				
				
				
				addChild(bCntrlPts[bCntrlPts.length -1]);
				//}
				bCntrlPts.push(new Sprite());
				
				drawPoint(bCntrlPts[bCntrlPts.length -1], 0xFF9900); 
				
				bCntrlPts[bCntrlPts.length -1].x = bezierPts[bezierPts.length-1].x;
				bCntrlPts[bCntrlPts.length -1].y = bezierPts[bezierPts.length-1].y;
				bCntrlPts[bCntrlPts.length -1].z = bezierPts[bezierPts.length-1].z;
				
				
				
				addChild(bCntrlPts[bCntrlPts.length -1]);
				
			}
			Update = true;
			drawCurve();
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
			if(bezierPts.length == 3){
				bezierPts[0].z = 0 - Main.liveCamera.pos.Z
				bezierPts[1].z = 0 - Main.liveCamera.pos.Z
				bezierPts[2].z = 80- Main.liveCamera.pos.Z
				bCntrlPts[0].z = 0 - Main.liveCamera.pos.Z
				bCntrlPts[1].z = 0 - Main.liveCamera.pos.Z
				bCntrlPts[2].z = 0 - Main.liveCamera.pos.Z
				bCntrlPts[3].z = 0 - Main.liveCamera.pos.Z
				bCntrlPts[4].z =80 - Main.liveCamera.pos.Z
				bCntrlPts[5].z = 80 - Main.liveCamera.pos.Z
				
			}
			if(EditKeyHandler.shift){
				newpt.x = EditKeyHandler.location.x;
				newpt.y = EditKeyHandler.location.y;
				draging();
			}else{
				// this structure was stupid and confusing but whatevs
				if(drag){
					oldpt.x = newpt.x
					oldpt.y = newpt.y
					newpt.x = EditKeyHandler.location.x;
					newpt.y = EditKeyHandler.location.y;
					
					delta_x = newpt.x - oldpt.x;
					delta_y = newpt.y - oldpt.y;
					s.x += delta_x
					s.y += delta_y
					if(!EditKeyHandler.cntrl){
						for (var i3:int = 2; i3 < bezierPts.length; i3++) 
						{
							if(s == bezierPts[i3]){
								bCntrlPts[2*i3].x += delta_x
								bCntrlPts[2*i3].y += delta_y
								bCntrlPts[2*i3+1].x += delta_x
								bCntrlPts[2*i3+1].y += delta_y
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
										bCntrlPts[i4+1].x += delta_x
										bCntrlPts[i4+1].y += delta_y
										bezierPts[i4/2].x += delta_x;
										bezierPts[i4/2].y += delta_y;
										if(lnkpts.length < 1)
											lnkpts.push(bCntrlPts[i4+1],bezierPts[i4/2])
										break;
										
									}else{
										bCntrlPts[i4-1].x += delta_x
										bCntrlPts[i4-1].y += delta_y
										bezierPts[(i4-1)/2].x += delta_x;
										bezierPts[(i4-1)/2].y += delta_y;
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
			dist = 0;
			pp.projectionCenter = new Point(MainSceneMotor.vpX,MainSceneMotor.vpY);
			pp.focalLength = MainSceneMotor.fl/1.7;
			transform.perspectiveProjection = pp;
			//line2Anchor(s,_point1,_control1);
			//line2Anchor(s,_point2,_control2);
			
			curve[i2] = [];
			_line.graphics.clear();  
			_line.graphics.lineStyle(1, 0xFF9900);  
			v.x = bezierPts[0].x; 
			v.y = bezierPts[0].y; 
			v.z = bezierPts[0].z;
			//stage..z =Main.liveCamera.pos.Z
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.moveTo(p.x, p.y);
			//			//trace(p.x, p.y);
			//			throw Error("jkh ")
			v.x = _control1.x; 
			v.y = _control1.y; 
			v.z = _control1.z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.lineTo(p.x,p.y);
			
			
			v.x = bezierPts[1].x; 
			v.y = bezierPts[1].y; 
			v.z = bezierPts[1].z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.moveTo(p.x, p.y);
			v.x = _control2.x; 
			v.y = _control2.y; 
			v.z = _control2.z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.lineTo(p.x,p.y);
			//			_line.graphics.moveTo(bezierPts[1].x, bezierPts[1].y);
			//			_line.graphics.lineTo(_control2.x, _control2.y);
			
			v.x = bezierPts[1].x; 
			v.y = bezierPts[1].y; 
			v.z = bezierPts[1].z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.moveTo(p.x, p.y);
			v.x = bCntrlPts[3].x; 
			v.y = bCntrlPts[3].y; 
			v.z = bCntrlPts[3].z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.lineTo(p.x,p.y);
			//_line.graphics.moveTo(bezierPts[1].x, bezierPts[1].y);
			//_line.graphics.lineTo(bCntrlPts[3].x, bCntrlPts[3].y);
			
			for (var k:int = 2; k < bezierPts.length; k++) 
			{
				v.x = bezierPts[k].x; 
				v.y = bezierPts[k].y; 
				v.z = bezierPts[k].z; 
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.moveTo(p.x, p.y);
				
				
				v.x = bCntrlPts[2*k].x; 
				v.y = bCntrlPts[2*k].y; 
				v.z = bCntrlPts[2*k].z; 
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.lineTo(p.x,p.y);
				//_line.graphics.moveTo(bezierPts[k].x, bezierPts[k].y);
				//_line.graphics.lineTo(bCntrlPts[2*k].x, bCntrlPts[2*k].y);
				
				v.x = bezierPts[k].x; 
				v.y = bezierPts[k].y; 
				v.z = bezierPts[k].z; 
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.moveTo(p.x, p.y);
				v.x = bCntrlPts[2*k+1].x; 
				v.y = bCntrlPts[2*k+1].y; 
				v.z = bCntrlPts[2*k+1].z; 
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.lineTo(p.x,p.y);
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
					v.x = (1-u)*(1-u)*(1-u)*bezierPts[0].x+3*(1-u)*(1-u)*u*_control1.x+3*(1-u)*u*u*_control2.x+(u*u*u)*bezierPts[1].x;
				v.y = (1-u)*(1-u)*(1-u)*bezierPts[0].y+3*(1-u)*(1-u)*u*_control1.y+3*(1-u)*u*u*_control2.y+(u*u*u)*bezierPts[1].y;
				v.z = (1-u)*(1-u)*(1-u)*bezierPts[0].z+3*(1-u)*(1-u)*u*_control1.z+3*(1-u)*u*u*_control2.z+(u*u*u)*bezierPts[1].z;
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
						v.x = (1-u)*(1-u)*(1-u)*bezierPts[j-1].x+3*(1-u)*(1-u)*u*bCntrlPts[2*j-1].x+3*(1-u)*u*u*bCntrlPts[2*j].x+(u*u*u)*bezierPts[j].x;
					v.y = (1-u)*(1-u)*(1-u)*bezierPts[j-1].y+3*(1-u)*(1-u)*u*bCntrlPts[2*j-1].y+3*(1-u)*u*u*bCntrlPts[2*j].y+(u*u*u)*bezierPts[j].y;
					v.z = (1-u)*(1-u)*(1-u)*bezierPts[j-1].z+3*(1-u)*(1-u)*u*bCntrlPts[2*j-1].z+3*(1-u)*u*u*bCntrlPts[2*j].z+(u*u*u)*bezierPts[j].z;
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
			
			_line.graphics.beginFill(0xFFFFFF);  
			
			
			
			
			for (var i:int = 0; i < curve.length; i++) {
				// this bit will be a tad complicated
				// we'll have to go through withought dynamic scaling for a bit 
				// and put it on last just use my local to global and draw the circlces small for now
				//				v.x = curve[][i].X
				//				v.y = curve[i].Y
				//				v.z = curve[i].Z
				//ill wanna use my own transformation thingy or i could just get it from the point method i made i dunno yet
				//p = local3DToGlobal(v);
				
				
				////trace(p,curve[i].X,curve[i].Y, "alse")
				//throw Error("ds")
				//_line.graphics.drawCircle(p.x,p.y, 1);  
			}  
			
			//
			
			
		}  
		
		public function updateBez():void
		{
			// just first check if lineSprites.length - 1 = the amount of lines we have if not then we need to add another one note it may need a check like if there are no points added yet we dont necessarily need to make another sprite but it really shouldnt be a big deal it should be just chilling htere which is perfectly fine
			
			// eventually we need one that uses the crazy method for swapping depth because of the z, but for now forget it
			while(lineSprites.length < curve.length) 
			{
				lineSprites.push(new Sprite)
				
				addChildAt(lineSprites[lineSprites.length - 1],0);
				
			}
			// we only have one linesprite we put this here when i wanted to expand this 
			for (var k:int = 0; k < lineSprites.length; k++) 
			{
				lineSprites[k].graphics.clear();
				lineSprites[k].graphics.lineStyle(1,0,1);
				lineSprites[k].graphics.beginFill(0xFFFFFF);
				
				for (var j:int = 0; j < curve[k].length; j++) 
				{
					// umm once you have this down you might wanna reconsider making an object out of all of em dividing em into three and putting em into a single array seems but for now whatever
					v.x = curve[k][j].X
					v.y = curve[k][j].Y
					v.z = curve[k][j].Z
					//ill wanna use my own transformation thingy or i could just get it from the point method i made i dunno yet
					p = MainSceneMotor.local3DToGlobal(v);
					if(j == 0){
						lineSprites[k].graphics.moveTo(p.x,p.y);
					}else{
						lineSprites[k].graphics.lineTo(p.x,p.y);
						lineSprites[k].graphics.drawCircle(p.x,p.y, 2*MainSceneMotor.fl/(MainSceneMotor.fl +v.z));
					}
				}
				for (var i:int = 0; i < bezierPts.length; i++) 
				{
					if(bezierPts.length == 3){
						bezierPts[0].z = 0 - Main.liveCamera.pos.Z
						bezierPts[1].z = 0 - Main.liveCamera.pos.Z
						bezierPts[2].z = 80- Main.liveCamera.pos.Z
						bCntrlPts[0].z = 0 - Main.liveCamera.pos.Z
						bCntrlPts[1].z = 0 - Main.liveCamera.pos.Z
						bCntrlPts[2].z = 0 - Main.liveCamera.pos.Z
						bCntrlPts[3].z = 0 - Main.liveCamera.pos.Z
						bCntrlPts[4].z =80 - Main.liveCamera.pos.Z
						bCntrlPts[5].z = 80 - Main.liveCamera.pos.Z
						
					}
				}
				
			}
			
			
		}
		
		private function draging():void
		{
			if(!shiftDragging){
				newY = EditKeyHandler.location.y;
				shiftDragging = true;
			}
			if(drag)
			{
				
				oldY = newY;
				newY = EditKeyHandler.location.y;
				deltaY = newY - oldY;
				//s.startDrag(true);
				s.z += deltaY
				if(!EditKeyHandler.cntrl){
					for (var i3:int = 2; i3 < bezierPts.length; i3++) 
					{
						if(s == bezierPts[i3]){
							bCntrlPts[2*i3].z += deltaY
							
							bCntrlPts[2*i3+1].z += deltaY
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
									bCntrlPts[i4+1].z += deltaY
									
									bezierPts[i4/2].z += deltaY
									if(lnkpts.length < 1)
										lnkpts.push(bCntrlPts[i4+1],bezierPts[i4/2])
									break;
									
								}else{
									bCntrlPts[i4-1].z += deltaY
									
									bezierPts[(i4-1)/2].z += deltaY
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
		
		private function line2Anchor(s:Sprite,p1:Sprite, p2:Sprite):void
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
		
		protected function MouseDown(event:MouseEvent):void
		{
			if(this == EditKeyHandler.bezTool){
				s = event.target as Sprite;  
				////trace(s.parent," this is the ",s, this)
				if(s == _line)
					return
				for each (var lsprt:Sprite in lineSprites) 
				{
					if(s == lsprt)
						return
				}
				// were adding way too many event listeners and thats dumb
				
				stage.addEventListener(MouseEvent.MOUSE_UP, onPointUp, false, 0, true); 
				if(s && s.parent == this){
					// its better to do it like this handling multiple states
					// we should look for focus too but i think it maybe cleaner to just not listen to event listeners during that
					
					
					drag = true;
					preEdit.x = s.x;
					preEdit.y = s.y;
					preEdit.z = s.z;
					
					error.x = EditKeyHandler.location.x - s.x;
					error.y = EditKeyHandler.location.x - s.x;
					newpt = EditKeyHandler.location
					_update = true;  
					_animate = false;
					if(EditKeyHandler.shift){
						newY = EditKeyHandler.location.y	
					}
					
					
				}else if(!(EditKeyHandler.State != bezier)){
					
					// obviously you wanna see if shift is down or whatever i really dont know
					bezierPts.push(new Sprite());
					
					bezierPts[bezierPts.length-1].x = EditKeyHandler.location.x;
					bezierPts[bezierPts.length-1].y = EditKeyHandler.location.y;
					bezierPts[bezierPts.length-1].z = Main.liveCamera.pos.Z;
					
					// and some random z based of focal length
					
					drawPoint(bezierPts[bezierPts.length-1]); 
					addChild(bezierPts[bezierPts.length-1]); 
					
					
					if(bezierPts.length == 2)
					{
						// a more advanced thing is you wanna do this but add a step count later to it
						bCntrlPts.push(new Sprite());
						bCntrlPts.push(new Sprite());
						bCntrlPts.push(new Sprite());
						bCntrlPts.push(new Sprite());
						drawPoint(_point1);  
						
						drawPoint(_control1, 0xFF9900);  
						drawPoint(_control2, 0xFF9900);  
						drawPoint(bCntrlPts[3], 0xFF9900);  
						// this is where you start everything and add the event listener
						bezierPts[0].x;  
						bezierPts[0].y;
						bezierPts[0].z;
						
						
						
						_control1.x = bCntrlPts[0].x = bezierPts[0].x; 
						_control1.y = bCntrlPts[0].y = bezierPts[0].y;
						_control1.z = bCntrlPts[0].z = bezierPts[0].z;
						
						bCntrlPts[1].x = bezierPts[0].x;
						bCntrlPts[1].y = bezierPts[0].y;
						bCntrlPts[1].z = bezierPts[0].z;
						
						_control2.x = bCntrlPts[2].x = bezierPts[1].x;  
						_control2.y = bCntrlPts[2].y = bezierPts[1].y;
						_control2.z = bCntrlPts[2].z = bezierPts[1].z;
						
						bCntrlPts[3].x = bezierPts[1].x;
						bCntrlPts[3].y = bezierPts[1].y;
						bCntrlPts[3].z = bezierPts[1].z;
						
						
						
						
						addChild(_control1);  
						addChild(_control2);
						addChild(bCntrlPts[3]);
						addChild(_sprite);  
						
						drawCurve();  
						
						
						Update = true;
					}else if(bezierPts.length > 2)
					{
						
						bCntrlPts.push(new Sprite());
						
						drawPoint(bCntrlPts[bCntrlPts.length -1], 0xFF9900); 
						
						bCntrlPts[bCntrlPts.length -1].x = bezierPts[bezierPts.length-1].x;
						bCntrlPts[bCntrlPts.length -1].y = bezierPts[bezierPts.length-1].y;
						bCntrlPts[bCntrlPts.length -1].z = bezierPts[bezierPts.length-1].z;
						
						
						
						addChild(bCntrlPts[bCntrlPts.length -1]);
						
						bCntrlPts.push(new Sprite());
						
						drawPoint(bCntrlPts[bCntrlPts.length -1], 0xFF9900); 
						
						bCntrlPts[bCntrlPts.length -1].x = bezierPts[bezierPts.length-1].x;
						bCntrlPts[bCntrlPts.length -1].y = bezierPts[bezierPts.length-1].y;
						bCntrlPts[bCntrlPts.length -1].z = bezierPts[bezierPts.length-1].z;
						
						
						
						addChild(bCntrlPts[bCntrlPts.length -1]);
						
						
						drawCurve(); 
					}
					
					updateBez();
				}
			}
		}
		
		public function onPointDown (x:Number, y:Number, z:Number):void {  
			
			if(EditKeyHandler.State == bezier){
				//s.startDrag(true);  
				_update = true;  
				_animate = false;
			}else{
				// obviously you wanna see if shift is down or whatever i really dont know
				bezierPts.push(new Sprite());
				
				bezierPts[bezierPts.length-1].x = x
				bezierPts[bezierPts.length-1].y = y;
				// and some random z based of focal length
				
				drawPoint(bezierPts[bezierPts.length-1]); 
				addChild(bezierPts[bezierPts.length-1]); 
				////trace(x," ",y);
				//stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown, false, 0, true);
				
			}
		}  
		
		
		
		private function onPointUp (event:MouseEvent):void {  
			stage.removeEventListener(MouseEvent.MOUSE_UP, onPointUp); 
			if(drag){
				EditKeyHandler.undoList.push({inc:1,x:preEdit.x,y:preEdit.y,z:preEdit.z,point:s, pts:lnkpts, bez:this})
				lnkpts= [];
				// stopDrag()
			}else{
				EditKeyHandler.undoList.push({inc:2, bez:this});
			}
			drag = false
			_update = false;  
			
		}  
		
		//update curve  
		public function onLoop ():void { 
			
			if (Update) {  
				//throw Error();
				drawCurve();  
			} else {  
				//move sprite!!!! 
				//				if (!_animate) {  
				//					linePath.points = _curve;  
				//					progress = 0;  
				//					a = 0.01;  
				//					linePath.snap(_sprite);  
				//					_animate = true;  
				//				}
				
			}
			if(_update)
				updateBez();
		}  
		
		// NOT NEEDED AT ALL
		//move sprite on the created curve  
		private function spriteLoop (event:Event = null):void {  
			//			if (_animate) {  
			//				progress += a;  
			//				if (progress <= 1) {  
			//					linePath.renderObjectAt(_sprite, progress);  
			//					a += 0.005;  
			//				} else {  
			//					
			//					//grab final speed and angle (you may use initial speed of contact for exit speed)  
			//					_sprite.x += linePath.totalLength*a*Math.cos(angle);  
			//					_sprite.y += linePath.totalLength*a*Math.sin(angle);  
			//					
			//				}  
			
			//			}  
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
		
		
		
		
		
		
		
	}  
}  