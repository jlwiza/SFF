package com.jonLwiza.engine.GeneralElements
{
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;

	/**
	 * <p> If Im using a lpair val is the distance in the Path, and path is clearly the place in the array [i]
	 * The way path works is that you give it a path then you have the choice of just 
	 */
	public class Path
	{
		private var _derivedPath:Array
		private var _ptsArray:Array;
		private var p1:Object = new Object();
		private var p2:Object = new Object();
		private var started:Boolean = true;
		// this gets overridden but just to show you the formatting
		//private var _lpair:Array = [{val:0,path:0},{val:50,path:1},{val:150,path:3}]
		private var _lpair:Array = []
		private var lp1:Object = new Object();
		private var lp2:Object = new Object();
		private var _isderivedPath:Boolean;
		private var ischecked:Boolean = false;
		private var _isDistanceChecked:Boolean = false;

		public var pcntgePrt:Number;
		private var _live:Boolean = false;
		public var endVal:Number = 200;
		public var relativePoints:Array = new Array()
		private var _begPt:Object
		private var _endPt:Object
		public var scale:Point = new Point()
		// you may wanna keep track of the scale in case i dunno maybe maybe not
		// ill place as needed
		// i may wanna do a replace path which makes sense
		// yeah if i have the rpath the original path becomes a waste of space
		public var rpath:Array
		private var scaleZ:Number =1;
		private var scaleY:Number = 1;
		private var scaleX:Number = 1;
		public function Path(ptArray:Array = undefined)
		{
			ptsArray = ptArray 
		}

		
		// so i neeeds to do something but im not sure exactly what
		// what i needs to do is bea better person and then i need to figure out what exactly i need to say ok move the images into place, then get the weird paralax down
		
		/**
		 * It takes the points the first and the last lerps them 
		 * and then sets all the points on the path relative to the position on the lerp
		 */
		public function relativePath(pts:Array):Array
		{
			//pts Array takes {X:1,Y:2,Z:3} in that format 
			// i only made it take in pts because i thought if i want to use this elsewhere it wouldnt take any changes in code
			var p0:Object = pts[0]
			var p1:Object = pts[pts.length-1]
			var rels:Array = new Array();
			var a:Number = Math.atan2(p1.Y - p0.Y,p1.X - p0.X)
			var a2:Number = Math.atan2(p1.Z - p0.Z,p1.X -p0.X)
				
			
			var cos:Number = Math.cos(a)
			var sin:Number = Math.sin(a)
			var c2:Number = Math.cos(a2)
			var s2:Number = Math.sin(a2)
			for (var i:int = 0; i < pts.length; i++) 
			{
			
			
			var l:Object = {}
			var rp:Object ={} 
			var t:Number = i/(pts.length - 1)
			
				
					// i think i can just get rid of(1 -t)*p0
				l.X=(1 -t)*p0.X + t*p1.X
				rp.X = (pts[i].X -p0.X) - (l.X - p0.X)
					
				l.Y= (1 -t)*p0.Y + t*p1.Y
				rp.Y = (pts[i].Y -p0.Y)- (l.Y - p0.Y)
					
				l.Z= (1 -t)*p0.Z + t*p1.Z
				rp.Z = (pts[i].Z -p0.Z)-(l.Z - p0.Z)
					
				 rels.push({
				X:rp.X*cos+rp.Y*sin,
				Y:rp.X*sin+rp.Y*-cos,
				//im pretty sure this is right but who knows honestly
				Z:rp.X*s2+rp.Z*-c2})
				
			}
			relativePoints = rels
			return rels
		}
		// I dunno probably some terrible debugging in store i am but who knows
		public function putPath(p0:Object,p1:Object):Array
		{
			var pts:Array = new Array() 
			
			var a:Number = Math.atan2(p1.Y - p0.Y,p1.X - p0.X)
			var a2:Number = Math.atan2(p1.Z - p0.Z,p1.X -p0.X)
			
			
			var cos:Number = Math.cos(a)
			var sin:Number = Math.sin(a)
			var c2:Number = Math.cos(a2)
			var s2:Number = Math.sin(a2)
			
				
			for (var i:int = 0; i < relativePoints.length; i++) 
			{
				var t:Number = i/(relativePoints.length - 1)
				var l:Object = {};	
				var r:Object = relativePoints[i]
				l.X = (1 - t)*p0.X + t*p1.X
				l.Y = (1 - t)*p0.Y + t*p1.Y
				l.Z = (1 - t)*p0.Z + t*p1.Z
					
				pts.push({
					X:l.X+r.X*cos*scaleX+r.Y*sin*scaleX,
					
					Y:l.Y+r.X*sin*scaleY+r.Y*-cos*scaleY,
					Z:l.Z+r.X*s2*scaleZ+r.Z*-c2*scaleZ
				})
				
				
				
			}
			
			
			return pts
		}
		
		// ok here is how im gonna check linked path 
		// remember val is unidirectional, dont go forward then backwards the array should easily support that
		public function pointOnLinkedPath(val:Number):Vector3
		{
			// i dont know why i didnt do both on linked value but i might have 
			//a reason I think I didnt want to confine path so I couldnt use linked value, and .. i doubt it though, well here is a convienence method j incase
			return placement(linkedValue(val))
		}
		/**
		 * linkedValue's val refers to the relationship in the distance in the path, meaning if I want for example to make a path myPath and wanted to pass a value progress into process that would return the first 3d point of the path at the first instance of the array myPath, and the last 3d point when I pass 100 I'd create an lpair[{val:0,path:0},{val:100,path:myArray.length()-1}], but ofcourse it doesnt have to be between any any values it can also start at - 70 as a value and end at -120 or 150 wherever, and anywhere inbetween
		 * also if you're altering the array repeatedly set the live property to true, If your just changing it once set isDistance checked to false, it's just an efficiency thing you have this big array and your doing squares so do it less,
		 */
		public function linkedValue(val:Number):Number{
			
			// this seems stupid and deprecated since i dont use it this way but made it so you could u
			if(lpair.length == 0){
				lpair = [{val:0,path:0},{val:endVal,path:ptsArray.length -1}]
			}
			// ok im only going to deal with a value between 0 and 1
			lpair[lpair.length - 1].val
				
				// lerp p1+(p2 - p1)*t =  p1(1 -t) + tp2 say i wanna find halfway point beteen 5 and 7 
				
			
			// I commented out that bit of code because I'm not entirely sure what itll do to pair array, and that needs testing before implementation
			if(!isDistanceChecked /*||ptsArray[ptsArray.length -1].D == 0*/){
				var dis:Number = 0
				ptsArray[0].D = 0
				for (i = 1; i < ptsArray.length; i++) 
				{
					ptsArray[i].D
					dis+=Math.sqrt((ptsArray[i].X - ptsArray[i-1].X)*(ptsArray[i].X - ptsArray[i-1].X)+(ptsArray[i].Y - ptsArray[i-1].Y)*(ptsArray[i].Y - ptsArray[i-1].Y)+(ptsArray[i].Z - ptsArray[i-1].Z)*(ptsArray[i].Z - ptsArray[i-1].Z))
					ptsArray[i].D = dis
					isDistanceChecked = true
				}
			}
			var isforward:Boolean = true
				if(lpair[lpair.length-1].val < lpair[0].val)
					isforward = false
						
			if(isforward){
			if(lpair[lpair.length-1].val < val)
			{
				
				return ptsArray[ptsArray.length-1].D

//			}else if(lpair[lpair.length -1].val >= val)
//			{
//				return ptsArray[ptsArray.length - 1];
			}else if(lpair[0].val >= val){
				
				return ptsArray[0].D
			}else{
			for (var i:int = 0; i < lpair.length; i++) 
			{
				
				
				if(lpair[i].val >= val)
				{
					// eh im guessing p1 is the first point and p2 is the second 
					lp1= lpair[i-1];
					lp2= lpair[i];
					started = true;
					////trace("the x is at :",actor.X);
					break
				}
			}
		}
			}else{
				if(lpair[lpair.length-1].val >= val)
				{
					
					return ptsArray[ptsArray.length-1].D
					
					//			}else if(lpair[lpair.length -1].val >= val)
					//			{
					//				return ptsArray[ptsArray.length - 1];
				}else if(lpair[0].val < val){
					
					return ptsArray[0].D
				}else{
					for (var i:int = 0; i < lpair.length; i++) 
					{
						
						
						if(lpair[i].val < val)
						{
							// eh im guessing p1 is the first point and p2 is the second 
							lp1= lpair[i-1];
							lp2= lpair[i];
							started = true;
							////trace("the x is at :",actor.X);
							break
						}
					}
				}
			}
			// this is a quick hack that hopefully fixes the problem of one path having more than the other
			//if(lp2.path > ptsArray.length-1 || lp1.path > ptsArray.length-1){
			//}
			pcntgePrt = (val - lp1.val)/(lp2.val - lp1.val)
				return pcntgePrt*(ptsArray[lp2.path].D - ptsArray[lp1.path].D)+ptsArray[lp1.path].D
		}
		
		/**
		 * its just its percentage, its a double inderection but whatever
		 */
		//public function f
		
		/**prg just refers to the distance in the path, but l
		 *  itd probably be better for ones that stay the same to put them into a table of some sort
		 * 
		 * **/
		public function placement(prg:Number):Vector3
		{
			// I honestly dont know if this works without weird shit on it... oh well
			
			if(isderivedPath)
				ptsArray = derivedPath
			
			if(!isDistanceChecked || live){
				var dis:Number = 0
				ptsArray[0].D = 0
				for (i = 1; i < ptsArray.length; i++) 
				{
					ptsArray[i].D
					dis+=Math.sqrt((ptsArray[i].X - ptsArray[i-1].X)*(ptsArray[i].X - ptsArray[i-1].X)+(ptsArray[i].Y - ptsArray[i-1].Y)*(ptsArray[i].Y - ptsArray[i-1].Y)+(ptsArray[i].Z - ptsArray[i-1].Z)*(ptsArray[i].Z - ptsArray[i-1].Z))
					ptsArray[i].D = dis
						isDistanceChecked = true
				}
			}
			// you have to be between 0 and 1 to work we'll do some conversion
			// check first then throw an error
			
			// this probably needs to be fixed but whatevs
			
			// it seems backwards but we just wanna unify the things regardless of their lengths, ya heard?
			// i dont wanna do that because well, its dumb because a distance from one point to the next is important and may be used if i wanna do that on my own time someplace else sure but i have the length here that i can take anytime its open
			//prg *= ptsArray[ptsArray.length -1].D;
			// we want to check if we've changed 
			
					
					
			if(ptsArray[0].D >= prg)
			{
				
				return new Vector3(ptsArray[0].X,ptsArray[0].Y,ptsArray[0].Z);
			}else if(ptsArray[ptsArray.length -1].D < prg)
			{
				return new Vector3(ptsArray[ptsArray.length - 1].X,ptsArray[ptsArray.length - 1].Y,ptsArray[ptsArray.length - 1].Z);
			}else{
				

				for (var i:int = 0; i < ptsArray.length; i++) 
				{
					
					//trace(i,ptsArray[i].D," ", prg)
					if(ptsArray[i].D >= prg)
					{
						
						// eh im guessing p1 is the first point and p2 is the second 
						p1= ptsArray[i-1];
						p2= ptsArray[i];
						////trace("the x is at :",actor.X);
						break
					}
				}
				
				
				
				return SnapToPath(prg,p1,p2);
			}
		}
		
		public static function SnapToPath(prgress:Number, pt1:Object, pt2:Object):Vector3
		{
			var a:Vector3 = new Vector3()
			// actor x is acutally the distance into the path
			//I wanna use ints for this eventually
			// p1[D] is the total distance to the first point in the entire array
			if(pt1){
				//D = 0;
				// i put d as zero so it would correspond to the x value, when its complete i need to factor in the z because we need to get the zx distances for each point and
				// i see no reason why it wouldnt just work right off the bat after i figure that out
				// so Dd tells us what the distance its traveled from p1
				var Dd:Number = prgress - pt1.D;
//				//trace(pt1);
				// then dV tells us whats the percentage distance its traveled to get to the next point
				var dv:Number = Dd/(pt2.D - pt1.D);
				//actor.X = ((actorX - p1[D])/p2[D])*(p2[X] - p1[X]) + p1[X];
				
				a.X = pt1.X + dv*(pt2.X - pt1.X);
				a.Y = pt1.Y + dv*(pt2.Y - pt1.Y);
				a.Z = pt1.Z + dv*(pt2.Z - pt1.Z);
				// i think i should make it more generic so that it returns a vector3, but whatevs
				
				
			}
			return a;
		}
		
		public function get ptsArray():Array
		{
			return _ptsArray;
		}

		public function set ptsArray(value:Array):void
		{
			_ptsArray = value;
		}

		public function get lpair():Array
		{
			return _lpair;
		}

		public function set lpair(value:Array):void
		{
			_lpair = value;
		}

		public function get derivedPath():Array
		{
			return _derivedPath;
		}

		public function set derivedPath(value:Array):void
		{
			_derivedPath = value;
		}

		public function get isderivedPath():Boolean
		{
			return _isderivedPath;
		}

		public function set isderivedPath(value:Boolean):void
		{
			_isderivedPath = value;
		}

		public function get isDistanceChecked():Boolean
		{
			return _isDistanceChecked;
		}

		public function set isDistanceChecked(value:Boolean):void
		{
			_isDistanceChecked = value;
		}

		public function get live():Boolean
		{
			return _live;
		}

		public function set live(value:Boolean):void
		{
			_live = value;
		}

		public function get begPt():Object
		{
			return _begPt;
		}

		public function set begPt(value:Object):void
		{
			_begPt = value;
			
			if(_endPt != null){
				ptsArray = putPath(_begPt,_endPt)
			}else{
				relativePoints = relativePath(ptsArray)
			}
			
		}

		public function get endPt():Object
		{
			return _endPt;
		}

		public function set endPt(value:Object):void
		{
			_endPt = value;
			
			if(_begPt != null){
				ptsArray = putPath(_begPt,_endPt)
			}else{
				relativePoints = relativePath(ptsArray)
			}
			
		}


	}
}