package com.jonLwiza.engine.helperTypes
{


	public class Vector3
	{
		
		private var _X:Number;
		private var _Y:Number;
		private var _Z:Number;
		private var _D:Number;
		public function Vector3(x:Number = 0, y:Number = 0,z:Number = 0)
		{
		   X = x;
		   Y = y;
		   Z = z;
		   
		   
		
		}
		
		public function pos(x:Number = 0, y:Number = 0,z:Number = 0):void
		{
			X = x;
			Y = y;
			Z = z;
		}
		
		public function get X():Number
		{
			return _X;
		}

		public function set X(value:Number):void
		{
			
			_X = value;
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

		public function get D():Number
		{
			return _D;
		}

		public function set D(value:Number):void
		{
			_D = value;
		}


	}
}