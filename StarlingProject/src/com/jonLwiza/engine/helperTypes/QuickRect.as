package com.jonLwiza.engine.helperTypes
{
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;

	public class QuickRect
	{
		private var _x:uint;
		private var _y:uint;
		private var _z:uint;
		private var _w:uint;
		private var _h:uint;
		/** its simple just put an array in here if you manually make it the var is x the next is y, width then height when you get to then next step dont forget to change this to include z */
		public function QuickRect(ar:Array = null,x:uint = 0, y:uint = 0, z:uint = 0, w:uint = 0, h:uint = 0)
		{
			if(ar != null){
				this.x = ar[0]
				this.y = ar[1]
				this.w = ar[2]
				this.h = ar[3]
			}else{
				this.x = x;
				this.y = y;
				this.z = z;
				this.w = w;
				this.h = h;
			}
			// um i can jsut change this later to include z no biggs
			
		}
		
		public function RectFromInts(x:uint = 0, y:uint = 0, z:uint = 0, w:uint = 0, h:uint = 0):void
		{	
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
			this.h = h;
			
		}
		
		public function hitTestObject(s:GeneralMotor):Boolean
		{
			// i dunno what this garbage is but ill make it
//			var dx:Number = s.x - x;
//			var dy:Number = s.y - y;
//			var dist:Number = Math.sqrt(dx*dx+dy*dy);
			var left1:uint, left2:uint;
			var right1:uint, right2:uint;
			var top1:uint, top2:uint;
			var bottom1:uint, bottom2:uint;
			
			left1 = x;//object1
			left2 = s.x;
			right1 = x + w;
			right2 =s.x + s.width;
			top1 = y;
			top2 = s.y;
			bottom1 = y + h;
			bottom2 = s.y + s.height;
			
			
			if(left1 < left2 && left2 < right1 && top1 < top2 && top2 < bottom1 ||
			left1 <left2 && left2 < right1 && bottom2 < bottom1 && top1 < bottom2 ||
			left1 < right2 && right2 < right1 && top1 < top2 && top2 < bottom1 ||
			left1 <right2 && right2 < right1 && bottom2 < bottom1 && top1 < bottom2 ||
			left1 < left2 && left2 < right1 && top2 < top1 && bottom1 < bottom2 ||
			right2 <right1 && left1 < right2 && top2 < top1 && bottom1 < bottom2 ||
			top1 < top2 && top2 < bottom1 && left2 < left1 && right1 < right2 ||
			bottom2 < bottom1 && top1 < bottom2 && left2 < left1 && right1 < right2)
				return true
//			if (bottom1 < top2) return true;
//			if (top1 > bottom2) return true;
//			
//			if (right1 < left2) return true;
//			if (left1 > right2) return true;
			
			return false;
			
			
			
//			if(dist < w/2 +s.width/2){
//				
//			//trace("were hitting the ", this)
//			return true;
//			}else{
//			
//			//trace("were not hitting ", dist," <",w/2+s.width/2)
//			return false;
//			}
		}
		
		public function get x():uint
		{
			return _x;
		}

		public function set x(value:uint):void
		{
			_x = value;
		}

		public function get y():uint
		{
			return _y;
		}

		public function set y(value:uint):void
		{
			_y = value;
		}

		public function get z():uint
		{
			return _z;
		}

		public function set z(value:uint):void
		{
			_z = value;
		}

		public function get w():uint
		{
			return _w;
		}

		public function set w(value:uint):void
		{
			_w = value;
		}

		public function get h():uint
		{
			return _h;
		}

		public function set h(value:uint):void
		{
			_h = value;
		}


	}
}