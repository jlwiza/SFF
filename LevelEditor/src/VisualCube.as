package
{
	import com.adobe.utils.ArrayUtil;
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class VisualCube extends Sprite
	{
		private var _line:Sprite = new Sprite();  
		private var _fPlaneZ:Number;
		private var _bPlaneZ:Number;
		private var s:Sprite = new Sprite(); 
		private var shiftDragging:Boolean = false;
		private var drag:Boolean = false;
		private var newX:Number;
		private var preEdit:Vector3D = new Vector3D();
		private var newpt:Point = new Point();
		
		private var origin:Point = new Point();
		private var boxwidth:Number;
		private var boxheight:Number;
		private var _update:Boolean;
		private var _animate:Boolean;
		private var dsqrpts:Array = new Array();
		private var dBsqrpts:Array = new Array();
		public static var boxes:Array= new Array();
		public var Update:Boolean;
		private var depth:Number = 30;
		private var pp:PerspectiveProjection = new PerspectiveProjection();
		private var p:flash.geom.Point;
		private var _attachedActor:GeneralMotor; 
		
		private var v:Vector3D = new Vector3D();
		private var fsqrpts:Array = new Array();
		private var backSqrpts:Array = new Array();
		private var frontSqrpts:Array = new Array();
		
		public function VisualCube(fPlaneZ:Number = 0, bPlaneZ:Number=0, depth:Number = 30)
		{
			if(fPlaneZ == 0){
			this.fPlaneZ = 10+Main.liveCamera.pos.Z;
			this.bPlaneZ = depth+Main.liveCamera.pos.Z;
			}else if (bPlaneZ == 0){
				this.bPlaneZ = depth+fPlaneZ
					
			}else{
				this.fPlaneZ = fPlaneZ
				this.bPlaneZ = bPlaneZ
			}
			
			
			
			
			
			
			this.depth = depth
			addChild(_line);
			addEventListener(Event.ADDED_TO_STAGE, loaded);
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
		
		protected function MouseDown(event:MouseEvent):void
		{
			if(this == EditKeyHandler.square){
				s = event.target as Sprite;
			}
			stage.addEventListener(MouseEvent.MOUSE_UP, onPointUp, false, 0, true); 
			
			if(s && s.parent == this){
				// its better to do it like this handling multiple states
				// we should look for focus too but i think it maybe cleaner to just not listen to event listeners during that
				drag = true;
				preEdit.x = s.x;
				preEdit.y = s.y;
				preEdit.z = s.z;
				
				boxwidth = EditKeyHandler.location.x - s.x;
				boxheight = EditKeyHandler.location.x - s.x;
				newpt = EditKeyHandler.location
				_update = true;  
				_animate = false;
				
				if(EditKeyHandler.shift){
					//probably not gonna use this but its here
					newX = EditKeyHandler.location.x	
				}
				
				
			}else if(EditKeyHandler.State == EditKeyHandler.BOX){
			
			if(frontSqrpts.length != 4)
			{	
				
				
				for (var i:int = 0; i < 4; i++) 
				{
					
					frontSqrpts.push(new Sprite());
					drawPoint(frontSqrpts[i]);
					addChild(frontSqrpts[i]);
					frontSqrpts[i].x = EditKeyHandler.location.x;
					frontSqrpts[i].y = EditKeyHandler.location.y;
					frontSqrpts[i].z = fPlaneZ
				}
				for (i= 0; i < 4; i++) 
				{
					backSqrpts.push(new Sprite());
					drawPoint(backSqrpts[i]);
					addChild(backSqrpts[i]);
					backSqrpts[i].x = EditKeyHandler.location.x;
					backSqrpts[i].y = EditKeyHandler.location.y;
					backSqrpts[i].z = bPlaneZ
				}
//				origin.x = EditKeyHandler.location.x;
//				origin.y = EditKeyHandler.location.y;

				//drawCurve();
				Update = true;

				
				
			}
		}
		}
		
		private function draging():void
		{
			
			if(drag)
			{
				var sqrpts:Array
				var osqrpts:Array
				var t:uint = 0
			
				//find out what point we are 
				for (var i:int = 0; i < frontSqrpts.length; i++) 
				{
					
					if(s == frontSqrpts[i]){
						sqrpts = frontSqrpts
						osqrpts = backSqrpts
						break;
					}
				}
				if(i == frontSqrpts.length)
				{	
					var backManip:Boolean = true
					for (i = 0; i < backSqrpts.length; i++) 
					{
						if(s == backSqrpts[i]){
							sqrpts = backSqrpts;
							osqrpts = frontSqrpts
							break;
						}
							
					}
					// this means we've clicked on a 
					if(i == backSqrpts.length)
					return
				}
				
				if(EditKeyHandler.shift){
					// this needs to be turned to newX
					var dz:Number = osqrpts[0].z - sqrpts[0].z
					for each (var j:Sprite in sqrpts) 
					{
						
						j.z = MainSceneMotor.relativeZfromx(EditKeyHandler.location, sqrpts[i].x)
					}
					if(EditKeyHandler.cntrl){
						for each (var h:Sprite in osqrpts) 
						{
							
							h.z = MainSceneMotor.relativeZfromx(EditKeyHandler.location, sqrpts[i].x)+dz
						}
					}
				}
				
				var location:Vector3D = MainSceneMotor.relativeXYZ(EditKeyHandler.location,sqrpts[0].z)
				while(t <2){
				
				switch(i)
				{
					case 0:
					{		
						sqrpts[0].x = location.x
						sqrpts[0].y = location.y
						
						
//						sqrpts[1].x = origin.x
						sqrpts[1].y = location.y
						
					
						
//						sqrpts[2].x = origin.x
//						sqrpts[2].y = origin.y
							
						sqrpts[3].x = location.x
//						sqrpts[3].y = origin.y
	
						break;
					}
					case 1:
					{
//						sqrpts[0].x = origin.x
						sqrpts[0].y = location.y
						
						sqrpts[1].x = location.x
						sqrpts[1].y = location.y
						
						sqrpts[2].x = location.x
//						sqrpts[2].y = origin.y
						
//						sqrpts[3].x = origin.x
//						sqrpts[3].y = origin.y
							

						break;
					}
					case 2:
					{
//						sqrpts[0].x = origin.x
//						sqrpts[0].y = origin.y
						//throw Error("not working")	
						sqrpts[2].x = location.x
						sqrpts[2].y = location.y
						
						sqrpts[1].x = location.x
//						sqrpts[1].y = origin.y
							
//						sqrpts[3].x = origin.x
						sqrpts[3].y = location.y
						
						break;
					}
					case 3:
					{
//						sqrpts[1].x = origin.x
//						sqrpts[1].y = origin.y
							
						
						sqrpts[3].x = location.x
						sqrpts[3].y = location.y
							
						sqrpts[0].x = location.x
//						sqrpts[0].y = origin.y
							
//						sqrpts[2].x = origin.x
						sqrpts[2].y = location.y
						break;
						
					}
						
					default:
					{
						break;
					}
				}
				t ++;
				sqrpts = osqrpts
				}
				
//				//trace(sqrpts[0].z.toString())
//				// we use the i to draw the curve and write where the points are
//				throw Error("dfd de")
				
				// okay now we have to get the position for its relative z
				// by determining if we are either the fplane or bplane
				// for now we'll assume were just using the fplane
				// later we'll ask it if its in the first array or the second
				//on mouse down then make that equal to square points so we wont have to ever care
				// so we put that all together and we should get a relative 
				
				depth = backSqrpts[0].z - frontSqrpts[0].z; 
				
//				dBsqrpts[0].Z = 17;
//				fsqrpts[0].Z = 3;
//
//				//trace(fsqrpts[0].Z.toString()+" "+dBsqrpts[0].Z.toString())
//				throw Error(fsqrpts[0].Z.toString()+" "+dBsqrpts[0].Z.toString())
				
				
				
				
				if(frontSqrpts[0].x > frontSqrpts[1].x){
					frontSqrpts[0].x = frontSqrpts[1].x
					backSqrpts[0].x = frontSqrpts[1].x
				}
				if(frontSqrpts[3].x > frontSqrpts[2].x){
					frontSqrpts[3].x = frontSqrpts[2].x
					backSqrpts[3].x = frontSqrpts[2].x
				}
				// umm ill get this to work later
				if(frontSqrpts[0].y > frontSqrpts[3].y){
					frontSqrpts[0].y = frontSqrpts[3].y
					backSqrpts[0].y = frontSqrpts[3].y
				}
				if(frontSqrpts[1].y > frontSqrpts[2].y){
					frontSqrpts[1].y = frontSqrpts[2].y
					backSqrpts[1].y = frontSqrpts[2].y
				}
				// umm ill get this to work later
				if(frontSqrpts[1].x < frontSqrpts[0].x){
					frontSqrpts[1].x = frontSqrpts[0].x
					backSqrpts[1].x = frontSqrpts[0].x
				}
				if(frontSqrpts[2].x < frontSqrpts[3].x){
					frontSqrpts[2].x = frontSqrpts[3].x
					backSqrpts[2].x = frontSqrpts[3].x
				}
				
				// this presents a problem an easy problem but a problem any ways we cant let the values of any of the other points
				// go less than the first point in any axes otherwise than its origin makes no sense
				// the origin of the character may be in the middle but i doubt it but if it is its not that big a deal
				if(attachedActor != null){
						
						//this may get wonky not to worry though 
						// ill fix it eventually
				attachedActor.X = frontSqrpts[0].x
				attachedActor.Y = frontSqrpts[0].y
				attachedActor.Z = frontSqrpts[0].z
				attachedActor.width = frontSqrpts[1].x- frontSqrpts[0].x
				attachedActor.height =frontSqrpts[3].y- frontSqrpts[0].y
				attachedActor.depth =  depth		
					}
			}
			
			
		}
		
		private function onPointUp (event:MouseEvent):void {  
			stage.removeEventListener(MouseEvent.MOUSE_UP, onPointUp); 
//			if(drag){
//				EditKeyHandler.undoList.push({inc:1,x:preEdit.x,y:preEdit.y,z:preEdit.z,point:s, pts:lnkpts, bez:this})
//				lnkpts= [];
//				// stopDrag()
//			}else{
//				EditKeyHandler.undoList.push({inc:2, bez:this});
//			}
			drag = false
			_update = false;  
			
		}  
		
		public function onPointDown (x:Number, y:Number, z:Number):void {  
			
			if(EditKeyHandler.State == EditKeyHandler.BOX){
				//s.startDrag(true);  
				_update = true;  
				_animate = false;
			}else{
				// obviously you wanna see if shift is down or whatever i really dont know
//				bezierPts.push(new Sprite());
//				
//				bezierPts[bezierPts.length-1].x = x
//				bezierPts[bezierPts.length-1].y = y;
//				// and some random z based of focal length
//				
//				drawPoint(bezierPts[bezierPts.length-1]); 
//				addChild(bezierPts[bezierPts.length-1]); 
				////trace(x," ",y);
				//stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown, false, 0, true);
				
			}
		}  
		public function drawCurve ():void {  
			
			
			pp.projectionCenter = new Point(MainSceneMotor.vpX,MainSceneMotor.vpY);
			pp.focalLength = MainSceneMotor.fl/1.7;
			transform.perspectiveProjection = pp;
			_line.graphics.clear();  
			_line.graphics.lineStyle(1, 0xFF9900); 
			
			draging()
			
			// this just makes the line into perspective
			//if(fsqrpts.length > 0){
				
			for (var k:int = 0; k < frontSqrpts.length; k++) 
			{
				v.x = frontSqrpts[k].x; 
				v.y = frontSqrpts[k].y; 
				v.z = frontSqrpts[k].z; 
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.moveTo(p.x, p.y);
				
				v.x = backSqrpts[k].x; 
				v.y = backSqrpts[k].y; 
				v.z = backSqrpts[k].z
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.lineTo(p.x,p.y);
			}
			v.x = frontSqrpts[0].x; 
			v.y = frontSqrpts[0].y; 
			v.z = frontSqrpts[0].z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.moveTo(p.x, p.y);
			for (k = 1; k < frontSqrpts.length; k++) 
			{
				v.x = frontSqrpts[k].x; 
				v.y = frontSqrpts[k].y; 
				v.z = frontSqrpts[k].z; 
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.lineTo(p.x, p.y);
			}
			v.x = frontSqrpts[0].x; 
			v.y = frontSqrpts[0].y; 
			v.z = frontSqrpts[0].z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.lineTo(p.x, p.y);
			
			v.x = backSqrpts[0].x; 
			v.y = backSqrpts[0].y; 
			v.z = backSqrpts[0].z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.moveTo(p.x, p.y);
//			backSqrpts[0].x = p.x
//			backSqrpts[0].y = p.y
			for (k = 1; k < backSqrpts.length; k++) 
			{
				v.x = backSqrpts[k].x; 
				v.y = backSqrpts[k].y; 
				v.z = backSqrpts[k].z; 
				p = MainSceneMotor.local3DToGlobal(v)
				_line.graphics.lineTo(p.x, p.y);
				
					}
			v.x = backSqrpts[0].x; 
			v.y = backSqrpts[0].y; 
			v.z = backSqrpts[0].z; 
			p = MainSceneMotor.local3DToGlobal(v)
			_line.graphics.lineTo(p.x, p.y);
			
			//}
		}
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
			//if(_update)
				//updateBez();
		}  

		public function get fPlaneZ():Number
		{
			return _fPlaneZ;
		}

		public function set fPlaneZ(value:Number):void
		{
			_fPlaneZ = value;
		}

		public function get bPlaneZ():Number
		{
			return _bPlaneZ;
		}

		public function set bPlaneZ(value:Number):void
		{
			_bPlaneZ = value;
		}

		public function get attachedActor():GeneralMotor
		{
			return _attachedActor;
		}

		public function set attachedActor(value:GeneralMotor):void
		{
			_attachedActor = value;
		}

		
	}
}